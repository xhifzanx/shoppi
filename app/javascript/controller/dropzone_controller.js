// app/javascript/controllers/dropzone_controller.js

import {Controller} from "stimulus";
import {DirectUpload} from "activestorage";

export default class extends Controller {

  uploadFile = (file, url, name) => {
    const upload = new DirectUpload(file, url, this);

    upload.create((error, blob) => {
      if (error) {
        // Handle the error
      } else {
        // Add an appropriately-named hidden input to the form with a
        //  value of blob.signed_id so that the blob ids will be
        //  transmitted in the normal upload flow
        const hiddenField = document.createElement('input');
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("value", blob.signed_id);
        hiddenField.name = name;
        this.element.querySelector('form').appendChild(hiddenField);
      }
    });
  };

  connect() {
    const root = this.element;
    const fileInputField = root.querySelector('input[type="file"]');
    const url = fileInputField.dataset.directUploadUrl;
    const name = fileInputField.name;

    fileInputField.remove();

    this.myDropzone = new Dropzone(root.querySelector('.dropzone-target'), {
      url,
      autoQueue: false,
      previewTemplate: '<div class="list-group-item w-100">\n' +
        '  <div class="row">' +
        '    <div class="col-2"><img data-dz-thumbnail class="img img-fluid" /></div>\n' +
        '    <div class="col-4">\n' +
        '        <span data-dz-size />\n' +
        '    </div><div class="col-6">\n' +
        '        <span data-dz-name></span>\n' +
        '    </div>\n' +
        '  </div><div class="row">\n' +
        '    <div class="col-12 mt-2"><div class="progress"><div class="progress-bar bg-dark" style="width:0%;" ></div></div></div>' +
        '  </div>\n' +
        '</div>',
      drop: (event) => {
        event.preventDefault();
        const files = event.dataTransfer.files;
        Array.from(files).forEach(file => this.uploadFile(file, url, name))
      }
    });
  }

  disconnect() {
    this.myDropzone = null;
  }

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress",
      event => this.directUploadDidProgress(event));
  }

  directUploadDidProgress(event) {
    const root = this.element;
    root.querySelector('.progress .progress-bar').style.width = `${event.loaded * 100 / event.total}%`;
  }

}