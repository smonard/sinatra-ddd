import React, { useEffect, useState } from "react";
import logo from './logo.svg';
import './App.css';
import { fetchPeople } from './services/personService'

function App() {
  const [people, setPeople] = useState();

  useEffect(() => {
    fetchPeople(setPeople);
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo.svg" />
        <p id="greetings">
          Hello world :)
        </p>
        { people && people.map((person) => (
            <div>
              {person.name}
            </div>
          ))
        }
      </header>
    </div>
  );
}

export default App;
