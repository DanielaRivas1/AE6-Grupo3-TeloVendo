//Función para resetear datos del formulario
const pageReload = evt => {
  location.reload();
}

//Función para validar datos del formulario
const formValidation = evt => {
  //Cancela el evento si este es cancelable, sin detener el resto del funcionamiento del evento, es decir, puede ser llamado de nuevo.
  evt.preventDefault();
  //evt.target contiene los elementos del form
  //El método trim( ) elimina los espacios en blanco en ambos extremos del string
  let name = evt.target['name'].value.trim();
  let email = evt.target['email'].value.trim();
  let txt = evt.target['floatingTextarea2'].value.trim();
  let check = 0; //si check es igual a 3 es que añadio los 3 campos ok

  //expresión regular 2 caracteres de letras ..
  let char2Regex = /^([A-Z]){2,}/i

  //en caso que el nombre sea vacio o no tenga menos 2 caracteres mostramos aviso de error
  if (name.length == 0) {
    document.getElementById('name-error').innerHTML = 'Error, el nombre no puede ser "vacio" debe iniciar al menos con 2 carácteres de letra.';
    document.getElementById('name-error').classList.remove('d-none');
  } else if (!char2Regex.test(name)) {
    document.getElementById('name-error').innerHTML = 'Error, su nombre debe iniciar al menos con 2 carácteres letra.';
    document.getElementById('name-error').classList.remove('d-none');
  } else {
    document.getElementById('name-error').className += ' d-none';
    check++;
  }

  //Expresion regular para validar correo, se copia de internet ... si se quiere jugar ir a (https://regexr.com/)
  let emailRegex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;

  //en caso que email sea vacio o no pase la expresión mostramos el aviso de error.
  if (email.length == 0) {
    document.getElementById('email-error').innerHTML = 'Error, el email no puede ser "vacio" debe ingresar un formato válido, ejemplo@dominio.cl';
    document.getElementById('email-error').classList.remove('d-none');
  } else if (!emailRegex.test(email)) {
    document.getElementById('email-error').innerHTML = 'Error, el email debe tener formato válido, ejemplo@dominio.cl';
    document.getElementById('email-error').classList.remove('d-none');
  } else {
    document.getElementById('email-error').className += ' d-none';
    check++;
  }

  //el textarea debe tener al menos 2 caracteres, en caso que no se cumpla mostramos el aviso de error
  if (txt.length == 0) {
    document.getElementById('txt-error').innerHTML = 'Error, el textarea no puede ser "vacio" debe iniciar un comentario con al menos 2 carácteres de letra.';
    document.getElementById('txt-error').classList.remove('d-none');
  } else if (!char2Regex.test(txt)) {
    document.getElementById('txt-error').innerHTML = 'Error, textarea debe iniciar el comentario con al menos 2 carácteres de letra.';
    document.getElementById('txt-error').classList.remove('d-none');
  } else {
    document.getElementById('txt-error').className += ' d-none';
    check++;
  }

  //Si el usuario ingreso los 3 campos bien
  if (check == 3) {
    document.getElementById('alert-container').classList.remove('d-none');
    //Desabilitamos, es decir no dejamos que el usuario escriba en los campos de entrada
    evt.target['name'].disabled = true;
    evt.target['email'].disabled = true;
    evt.target['floatingTextarea2'].disabled = true;
    evt.target['form__submit'].disabled = true;
    evt.target['form__reset'].disabled = true;
  }
}

//Seleccionamos la etiqueta form del formulario de contacto
let contactForm = document.getElementById('contact-form');

//Si el formulario se envia (submit) ejecutamos la funcion formValidation
contactForm.addEventListener('submit', formValidation);

/*Evento asociado a close del componente alert, apuntamos directo al boton
recargamos porque una vez que se cierra alert desapare del documento
*/
let closeContactAlert = document.getElementById('contact-alert__btn-close');
closeContactAlert.addEventListener('click', pageReload)

/*
Documentación Bootstrap da ejemplo utilizando jquery .... para realizar acciones al cerrar el alert, pero como no se ha visto seguimos con JS que hace algo similar a lo que podria hacer con lo sgte:
$('#contact-alert').on('closed.bs.alert', function () {
  // do something...
  pageReload();
})
*/