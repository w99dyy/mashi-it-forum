import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["menu"]

    connect() {
        this.hideHandler = (event) => this.hide(event)
        document.addEventListener("click", (event) => this.hide(event))
    }

    disconnect() {
        document.removeEventListener("click", this.hideHandler)
    }

    toggle() {
        this.menuTarget.classList.toggle("hidden")
    }

    hide(event) {
        if (!this.element.contains(event.target)) {
            this.menuTarget.classList.add("hidden")
        }
    }
}
