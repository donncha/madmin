import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  static values = {
    options: Object,
    url: String,
    minLength: Number
  }

  connect() {
    let options = {
      plugins: ['remove_button'],
      valueField: 'id',
      labelField: 'name',
      searchField: 'name'
    }

    if (this.hasMinLengthValue) {
      options["shouldLoad"] = (searchTerm) => {
        return searchTerm.length >= this.minLengthValue;
      }
    }

    if (this.hasUrlValue) {
      options["load"] = (search, callback) => {
        let url = search ? `${this.urlValue}?q[haystack]=${search}` : this.urlValue;
        fetch(url)
          .then(response => response.json())
          .then(json => {
            callback(json);
          }).catch(() => {
            callback();
          });
      }
    }

    this.select = new TomSelect(this.element, options)
  }

  disconnect() {
    this.select.destroy()
  }
}
