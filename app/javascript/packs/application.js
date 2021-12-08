// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import FroalaEditor from "froala-editor"
import 'froala-editor/js/plugins.pkgd.min.js';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", function() {
  new FroalaEditor('.expanded-by-editor', {
    quickInsertEnabled: false
  })
  new FroalaEditor('.expanded-by-editor-mini', {
    toolbarButtons: ['bold', 'italic', 'underline', 'undo', 'redo'],
    quickInsertEnabled: false
  })
})