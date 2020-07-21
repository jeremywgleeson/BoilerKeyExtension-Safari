console.log("script loaded");

if (window.location.href.startsWith("https://mycourses.purdue.edu/") === true
    && document.getElementsByClassName("purdue-btn-bottom-row")[0] !== null
    && document.getElementsByClassName("purdue-btn-bottom-row")[0] !== undefined) {

    document.getElementsByClassName("purdue-btn-bottom-row")[0].click();
}

//Make sure we're on Purdue's CAS then get username and password
if (window.location.href.startsWith("https://www.purdue.edu/apps/account/cas/login") === true) {
    console.log("dispatching message");
    safari.extension.dispatchMessage("getLogin");
}

safari.self.addEventListener("message", handleLogin);
var login;


/*
 Submit data:
 MIME Type: application/x-www-form-urlencoded
 username: asdfasdf
 password: 1234,push
 lt: LT-4212846-12CuCOeqdaLwMqZ7efopsOFakC7puH
 execution: e1s1
 _eventId: submit
 submit: Logi
 */
//function submitForm(username, password) {
//    const script = document.createElement('script');
//    script.type = "text/javascript";
//    script.innerHTML = 'var req = new XMLHttpRequest();req.open("POST", "/apps/account/cas/login?service=https%3A%2F%2Fmycourses.purdue.edu%2F", true);';
//    script.innerHTML += 'req.send(JSON.stringify({';
//    script.innerHTML += '"MIME Type": "application/x-www-form-urlencoded",';
//    script.innerHTML += '"username": ' + '"' + username + '"' + ",";
//    script.innerHTML += '"password": ' + '"' + password + '"' + ",";
//    script.innerHTML += '"execution": "e1s1",';
//    script.innerHTML += '"_eventId": "submit",';
//    script.innerHTML += '"submit": "Login"}));';
//    console.log(script.innerHTML);
//    document.head.appendChild(script);
//}

//function post(path, params, method='post') {
//
//  // The rest of this code assumes you are not using a library.
//  // It can be made less wordy if you use one.
//  const form = document.createElement('form');
//  form.method = method;
//  form.action = path;
//
//  for (const key in params) {
//    if (params.hasOwnProperty(key)) {
//      const hiddenField = document.createElement('input');
//      hiddenField.type = 'hidden';
//      hiddenField.name = key;
//      hiddenField.value = params[key];
//
//      form.appendChild(hiddenField);
//    }
//  }
//
//  document.body.appendChild(form);
//  form.submit();
//}

function handleLogin(event) {
    if (event.name == "login") {
        console.log("login recieved")
        login = event.message;
        // need to wait for page load to insert
        if (document.readyState === "complete"
             || document.readyState === "loaded"
             || document.readyState === "interactive") {
             // document has at least been parsed
            document.getElementById("username").value = login["username"];
            document.getElementById("password").value = login["password"];
            document.querySelectorAll("input[name='submit'][accesskey='s'][value='Login'][tabindex='3'][type='submit']")[0].click();
            submitForm(login["username"], login["password"]);
        } else {
            document.addEventListener("DOMContentLoaded", function(event) {
//                submitForm(login["username"], login["password"]);
                
                document.getElementById("username").value = login["username"];
                document.getElementById("password").value = login["password"];
                document.querySelectorAll("input[name='submit'][accesskey='s'][value='Login'][tabindex='3'][type='submit']")[0].click();
            });
        }
    }
}
