// app/javascript/controllers/wallet_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  async connect() {
    this.setupMetaMaskListeners()
  }

  setupMetaMaskListeners() {
    if (!window.ethereum) return

    window.ethereum.removeAllListeners('accountsChanged')
    window.ethereum.removeAllListeners('chainChanged')

    window.ethereum.on('accountsChanged', (accounts) => {
      if (accounts.length === 0) this.disconnectWallet()
    })

    window.ethereum.on('chainChanged', () => window.location.reload())
  }

  async toggle() {
    const isConnected = this.buttonTarget.textContent.trim() === "Disconnect Wallet"
    isConnected ? await this.disconnectWallet() : await this.connectWallet()
  }

  async connectWallet() {
    try {
      this.buttonTarget.disabled = true
      this.buttonTarget.textContent = "Connecting..."

      if (!window.ethereum) {
        window.open("https://metamask.io/download/")
        throw new Error("Please install MetaMask first")
      }

      const accounts = await window.ethereum.request({ method: "eth_requestAccounts" })
      if (!accounts?.length) throw new Error("No accounts found")

      const address = accounts[0].toLowerCase()

      const availabilityRes = await fetch("/wallet/check_availability", {
        method: "POST",
        headers: this.jsonHeaders(),
        body: JSON.stringify({ wallet_address: address })
      })
      if (!availabilityRes.ok) {
        const err = await availabilityRes.json()
        throw new Error(err.message || "Wallet unavailable")
      }

      const connectRes = await fetch("/wallet/connect", {
        method: "POST",
        headers: this.jsonHeaders(),
        body: JSON.stringify({ wallet_address: address })
      })
      if (!connectRes.ok) {
        const err = await connectRes.json()
        throw new Error(err.error || "Failed to save wallet")
      }

      window.location.reload()

    } catch (error) {
      console.error("❌ Connection error:", error)
      alert(error.message || "Failed to connect wallet")
      this.buttonTarget.disabled = false
      this.buttonTarget.textContent = "Connect Wallet"
    }
  }

  async disconnectWallet() {
    try {
      this.buttonTarget.disabled = true
      this.buttonTarget.textContent = "Disconnecting..."

      await fetch("/wallet/disconnect", {
        method: "POST",
        headers: this.jsonHeaders()
      })

      if (window.ethereum) {
        try {
          await window.ethereum.request({
            method: 'wallet_revokePermissions',
            params: [{ eth_accounts: {} }]
          })
        } catch (_) {}
      }

      window.location.reload()

    } catch (error) {
      console.error("❌ Disconnect error:", error)
      this.buttonTarget.disabled = false
      this.buttonTarget.textContent = "Disconnect Wallet"
    }
  }

  jsonHeaders() {
    return {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')?.content
    }
  }
}