document.addEventListener('DOMContentLoaded', function () {

    const myId = sessionStorage.getItem("myId");
    console.log(myId);

    fetch(`/api/1.0/users/${myId}/name`)
        .then(response => response.text())
        .then(name => {
            console.log("name");
            console.log(name);
            console.log("document.getElementById('welcome-message')");
            console.log(document.getElementById('welcome-message'));
            document.getElementById('welcome-message').textContent = '您好，' + name;
        });

    fetch('/header')
        .then(response => response.text())
        .then(data => {
            document.getElementById('header-placeholder').innerHTML = data;

            document.addEventListener('DOMContentLoaded', function () {
                const hamburger = document.querySelector('.hamburger');
                const mainNav = document.querySelector('.main-nav');
                console.log("hamburger");
                hamburger.addEventListener('click', function () {
                    mainNav.classList.toggle('active');
                });
            });

            const chatroomLink = document.getElementById('chatroom-link');
            console.log("chatroomLink");
            console.log(chatroomLink);
            const chatroomList = document.getElementById('chatroom-list');
            // Toggle chatroom list on chatroom link click
            chatroomLink.addEventListener('click', function (event) {

                console.log("I've clicked header html")
                event.preventDefault(); // Prevent default link behavior
                if (chatroomList.style.display === 'block') {
                    chatroomList.style.display = 'none';
                } else {
                    chatroomList.style.display = 'block';
                    console.log("updateChatroomList" + currentUserId);
                    updateChatroomList(currentUserId); // Update the list when showing
                }
            });

        });

})
;


