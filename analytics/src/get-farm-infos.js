export default async function (archethic, contractAddress) {
  return archethic.network.callFunction(contractAddress, "get_farm_infos", []);
}
