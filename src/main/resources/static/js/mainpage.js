document.addEventListener('DOMContentLoaded', function () {
    fetch('/header')
        .then(response => response.text())
        .then(data => {
            document.getElementById('header-placeholder').innerHTML = data;
        });

    const rentalButton = document.querySelector('.button-rental');
    rentalButton.addEventListener('click', function () {
        window.location.href = '/rental-form';  // Redirect to /rental-form
    });
});
