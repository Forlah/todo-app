/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.hs",
    "./src/**/*.html",
    "./src/**/*.javascript"
  ],
  theme: {
    extend: {},
  },
  plugins: [require("tailwindcss")],
};