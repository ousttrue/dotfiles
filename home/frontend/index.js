document.addEventListener("DOMContentLoaded", (event) => {
  console.log("DOM fully loaded and parsed");

  const url =
    (location.protocol === 'https:' ? 'wss://' : 'ws://')
    + location.hostname
    + (location.port ? `:${location.port}` : '')
    + '/ws';
  // const url = `${window.location.origin}/ws`;
  console.log(url);
  const socket = new WebSocket(url);
  socket.onopen = function() {
    append_message("system", "connect to server");
  };
  socket.onmessage = function(event) {
    // サーバーからメッセージを受け取る
    append_message("server", event.data);
  };

  // メッセージ欄を更新する
  function append_message(name, message) {
    let li_name = document.createElement("li");
    let name_txt = document.createTextNode(name);
    li_name.appendChild(name_txt);

    let ul_message = document.createElement("ul");

    let li_message = document.createElement("li");
    let message_txt = document.createTextNode(message);
    li_message.appendChild(message_txt);

    ul_message.appendChild(li_message);

    li_name.appendChild(ul_message);

    let ul = document.getElementById("messages");
    ul.appendChild(li_name);
  }

  // サーバーにメッセージを送信する
  function send() {
    let send_msg = document.getElementById("message");
    let msg = send_msg.value;
    if (msg == "") {
      return;
    }
    socket.send(msg);
    append_message("you", msg);
    send_msg.value = "";
  }
});


