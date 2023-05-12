importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
  apiKey: "AIzaSyC36QGj3FRsMa4qomCOSVAA5DpnJU62kMU",
  authDomain: "jetcare-f4e39.firebaseapp.com",
  projectId: "jetcare-f4e39",
  storageBucket: "jetcare-f4e39.appspot.com",
  messagingSenderId: "873102526889",
  appId: "1:873102526889:web:459167752edf3695015cb8",
  measurementId: "G-VE6C9EWW39"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});