import { Application } from "stimulus"
import { Turbo } from "@hotwired/turbo-rails"

const messagesChannel = Turbo.connectStreamSource("/cable/messages_channel")

messagesChannel.subscriptions.create("MessagesChannel", {
  received(data) {
    // Manejar el evento en tiempo real
    const message = data.message;
    // Actualizar la interfaz de usuario para mostrar la notificación del nuevo mensaje
  }
})