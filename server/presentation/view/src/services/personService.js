import 'regenerator-runtime/runtime'

const fetchPeople = async (setPeople) => {
  const response = await fetch(
    "/persons"
  ).then((response) => response.json());

  setPeople(response);
};

export { fetchPeople };