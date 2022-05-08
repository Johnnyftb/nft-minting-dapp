export default function Navbar() {

    return (
        <nav className="navbar navbar-expand-lg bg-primary shadow">
            <div className="container p-3 text-light d-flex flex-column align-items-center">
                <h1>Baker Boys Minting Dapp</h1>
                <p className="lead mb-0">Made By</p>
                <img src="/images/logo.png" alt="" className="img-fluid" />
            </div>
        </nav>
    )
}