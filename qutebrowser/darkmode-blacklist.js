// ==UserScript==
// @match https://www.desmos.com/*
// @match http://127.0.0.1*
// @run-at document-end
// ==/UserScript==

const meta = document.createElement('meta');
meta.name = "color-scheme";
meta.content = "dark light";
document.head.appendChild(meta);
