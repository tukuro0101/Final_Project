import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import { Turbo } from "@hotwired/turbo-rails"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
Turbo.setProgressBarDelay(200)
