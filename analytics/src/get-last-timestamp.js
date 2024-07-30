export default function (archethic, address) {
  return archethic.network
    .rawGraphQLQuery(
      `
    query {
      lastTransaction(address: "${address}"){
        validationStamp {
          timestamp
        }
      }
    }
  `,
    )
    .then((response) => response.lastTransaction.validationStamp.timestamp);
}
