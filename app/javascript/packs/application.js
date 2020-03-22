// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks");
require("css/application.css");
// import '../css/application.css'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import Cookies from 'js-cookie'

function switchTheme() {
    const light = "theme-light";
    const dark = "theme-dark";
    if (Cookies.get('lightTheme?')) {
        let isLight = Cookies.get('lightTheme?') === 'true';
        if (isLight) {
            document.getElementById("html").classList.replace(light, dark);
        } else {
            document.getElementById("html").classList.replace(dark, light);
        }
        Cookies.set('lightTheme?', !isLight, {expires: 1000});

    } else {
        document.getElementById("html").classList.replace(dark, light);
        Cookies.set('lightTheme?', 'false', {expires: 1000});
    }
}

const switchBtn = document.getElementById('ThemeSwitchBtn');
switchBtn.addEventListener('click', switchTheme);