import consumer from "./consumer"

consumer.subscriptions.create({ channel: "AlertsChannel" },

  connected() {
    console.log("Connected");
  },

  disconnected() {
    console.log("Discnnected");
  },

  received(data) {
    console.log(data);
  }
)