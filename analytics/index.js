import cron from "node-cron";
import config from "config";
import Archethic from "@archethicjs/sdk";
import express from "express";
import Debug from "debug";

const debug = Debug("server");
const ENDPOINT = config.get("archethic.endpoint");
const CONTRACT_ADDRESS = config.get("dex.farmlock.address");
const SCHEDULER_ADDRESS = config.get("dex.farmlock.schedulerAddress");

let FARM_INFOS = null;
let LATEST_TIMESTAMP = null;
let BALANCE_SCHEDULER = null;

import getFarmInfos from "./src/get-farm-infos.js";
import getLastTimestamp from "./src/get-last-timestamp.js";
import getUCOBalance from "./src/get-uco-balance.js";

debug(`Connecting to endpoint ${ENDPOINT}...`);
const archethic = new Archethic(ENDPOINT);
await archethic.connect();
debug(`Connected!`);

const app = express();
const port = config.get("port");

app.get("/metrics", (req, res) => {
  let text = "";

  if (FARM_INFOS) {
    text += farm_infos_to_metrics(FARM_INFOS);
  }
  if (LATEST_TIMESTAMP) {
    text += latest_timestamp_to_metrics(LATEST_TIMESTAMP);
  }
  if (BALANCE_SCHEDULER) {
    text += scheduler_balance_to_metrics(BALANCE_SCHEDULER);
  }

  if (req.get("accept").includes("html")) {
    res.send(`<html><body><pre>${text}</pre></body></html>`);
  } else {
    res.send(text);
  }
});

debug(`Starting HTTP server on port ${port}...`);
app.listen(port, () => {
  debug(`Started!`);
});

tick();
cron.schedule(config.get("cron"), async () => {
  await tick();
});

async function tick() {
  debug("tick-start");

  let [farmInfos, latestTimestamp, balanceScheduler] = await Promise.all([
    getFarmInfos(archethic, CONTRACT_ADDRESS),
    getLastTimestamp(archethic, CONTRACT_ADDRESS),
    getUCOBalance(archethic, SCHEDULER_ADDRESS),
  ]);

  FARM_INFOS = farmInfos;
  LATEST_TIMESTAMP = latestTimestamp;
  BALANCE_SCHEDULER = balanceScheduler;
  debug("tick-end");
}

function farm_infos_to_metrics(farm_infos) {
  return `#TYPE archethic_dex_farm_remaining_rewards gauge\narchethic_dex_farm_remaining_rewards ${farm_infos.remaining_rewards}\n`;
}

function latest_timestamp_to_metrics(timestamp) {
  return `#TYPE archethic_dex_farm_latest_timestamp gauge\narchethic_dex_farm_latest_timestamp ${timestamp}\n`;
}

function scheduler_balance_to_metrics(balance) {
  return `#TYPE archethic_dex_farm_scheduler_balance gauge\narchethic_dex_farm_scheduler_balance ${balance}\n`;
}
