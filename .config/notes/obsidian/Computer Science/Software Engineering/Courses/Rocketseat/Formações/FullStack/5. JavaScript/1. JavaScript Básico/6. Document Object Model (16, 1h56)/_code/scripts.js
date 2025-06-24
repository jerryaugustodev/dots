// 03. Acessando elementos no DOM
const guest = document.getElementById("guest-2");
console.log(guest);

console.dir(guest);

const guestsByClass = document.getElementsByClassName("guest");
console.log(guestsByClass);

console.dir(guestsByClass.item(0));
console.dir(guestsByClass[0]);

const guestsByTag = document.getElementsByTagName("li");
console.log(guestsByTag);

// 04. Query selector
const guestByQuery = document.querySelector("#guest-2"); // ID
console.log(guestByQuery);

const guestsByQuery = document.querySelector(".guest"); // Only returns the first element
const guestsAllByQuery = document.querySelectorAll(".guest");
console.log(guestsByQuery);
console.log(guestsAllByQuery);

// 05. Manipulando conteúdo
const guestMan = document.querySelector("#guest-1 span");
console.log(guestMan.textContent);

guestMan.textContent = "John Doe";

const input = document.querySelector("#name");
input.classList.toggle("input-error");

const button = document.querySelector("button");
button.style.backgroundColor = "violet";

const guests = document.querySelector("ul");

const newGuest = document.createElement("li");
const guestName = document.createElement("span");

guestName.textContent = "Mary Jane";

newGuest.append(guestName);
