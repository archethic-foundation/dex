import Archethic, { Utils } from "@archethicjs/sdk";
import config from "../../config.js";
import fs from "fs";
import { getServiceGenesisAddress } from "../utils.js";

const command = "deploy_farm_scheduler";
const describe = "Deploy the farm' scheduler";
const builder = {
  access_seed: {
    describe: "The Keychain access seed (default in env config)",
    demandOption: false,
    type: "string",
  },
  contract_farm_lock_address: {
    describe: "The address in hexadecimal of the farm lock contract",
    demandOption: false,
    type: "string",
  },
  env: {
    describe: "The environment config to use (default to local)",
    demandOption: false,
    type: "string",
  },
};

const handler = async function (argv) {
  const envName = argv["env"] ? argv["env"] : "local";
  const env = config.environments[envName];

  const keychainAccessSeed = argv["access_seed"]
    ? argv["access_seed"]
    : env.keychainAccessSeed;

  if (keychainAccessSeed == undefined) {
    console.log("Keychain access seed not defined");
    process.exit(1);
  }

  const contractFarmLockAddress = argv["contract_farm_lock_address"];
  if (!contractFarmLockAddress) {
    console.log("Missing --contract_farm_lock_address");
    process.exit(1);
  }

  const archethic = new Archethic(env.endpoint);
  await archethic.connect();

  let keychain;

  try {
    keychain = await archethic.account.getKeychain(keychainAccessSeed);
  } catch (err) {
    console.log(err);
    process.exit(1);
  }

  const genesisAddress = getServiceGenesisAddress(keychain, "Farm-Scheduler");
  console.log("Scheduler genesis address:", genesisAddress);

  const contractCode = fs
    .readFileSync("./contracts/farm_lock_scheduler.exs", "utf8")
    .replace("@FARM_LOCK_CONTRACT_ADDRESS", `0x${contractFarmLockAddress}`);

  const index = await archethic.transaction.getTransactionIndex(genesisAddress);

  const storageNonce = await archethic.network.getStorageNoncePublicKey();
  const { secret, authorizedPublicKeys } = keychain.ecEncryptServiceSeed(
    "Farm-Scheduler",
    [storageNonce],
  );

  let tx = archethic.transaction
    .new()
    .setType("contract")
    .setCode(contractCode)
    .addOwnership(secret, authorizedPublicKeys);

  tx = keychain
    .buildTransaction(tx, "Farm-Scheduler", index)
    .originSign(Utils.originPrivateKey);

  tx.on("sent", () => console.log("transaction sent !"))
    .on("requiredConfirmation", async (_confirmations) => {
      const txAddress = Utils.uint8ArrayToHex(tx.address);
      console.log("Transaction validated !");
      console.log("Address:", txAddress);
      console.log(env.endpoint + "/explorer/transaction/" + txAddress);
      process.exit(0);
    })
    .on("error", (context, reason) => {
      console.log("Error while sending transaction");
      console.log("Contest:", context);
      console.log("Reason:", reason);
      process.exit(1);
    })
    .send(50);
};

export default {
  command,
  describe,
  builder,
  handler,
};
