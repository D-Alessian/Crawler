import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value", "list"]
  targetValue = null

  connect () {
  }

  update () {
    this.targetValue = this.valueTarget.value
  }

  renderAdd () {
    if (this.isLink(this.targetValue)) {
      if (this.isHttp(this.targetValue)) {
        this.listTarget.innerHTML += (`<li><a href="${this.targetValue}">${this.targetValue}</a></li>`)
      } else {
        this.listTarget.innerHTML += (`<li><a href="https://${this.targetValue}">${this.targetValue}</a></li>`)
      }
    } else {
      this.listTarget.innerHTML += (`<li>${this.targetValue}</li>`)
    }
  }

  renderRemove () {
    if (this.isLink(this.targetValue)) {
      if (this.isHttp(this.targetValue)) {
        this.listTarget.innerHTML = this.listTarget.innerHTML.replace(`<li><a href="${this.targetValue}">${this.targetValue}</a></li>`, '')
      } else {
        this.listTarget.innerHTML = this.listTarget.innerHTML.replace(`<li><a href="https://${this.targetValue}">${this.targetValue}</a></li>`, '')
      }
    } else {
      this.listTarget.innerHTML = this.listTarget.innerHTML.replace(`<li>${this.targetValue}</li>`, '')
    }
  }

  isLink (stringToCheck) {
    return stringToCheck.match(/(http)?s?(:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)/)
  }
   
  isHttp (stringToCheck) {
    return stringToCheck.startsWith("http://") || stringToCheck.startsWith("https://")
  }

}
