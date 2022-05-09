import './App.css';
import { Navbar, Content } from "./components/index";
import {DAppProvider, Rinkeby} from "@usedapp/core";

function App() {
  return (
    <DAppProvider config={{networks: [Rinkeby]}}>
      <div className="App">
        <Navbar />
        <Content />
      </div>
    </DAppProvider>
    
  );
}

export default App;
