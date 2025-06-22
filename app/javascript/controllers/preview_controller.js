import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value", "list"]
  targetValue = null

  connect () {
  }

  update () {
    this.targetValue = this.valueTarget.value
  }

  render () {
    this.listTarget.innerHTML += (`<li>${this.targetValue}</li>`)
  }

  renderWithHyperlink () {
    this.listTarget.innerHTML += (`<li><a href="https://${this.targetValue}">${this.targetValue}</a></li>`)
  }

}
