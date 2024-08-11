import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log("Dropdown controller connected")
  }

  show() {
    this.menuTarget.classList.add("show")
  }

  hide() {
    this.menuTarget.classList.remove("show")
  }
  
  toggle() {
    this.menuTarget.classList.toggle("show")
  }

}

