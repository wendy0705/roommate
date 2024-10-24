document.addEventListener('DOMContentLoaded', function () {

    const myId = sessionStorage.getItem("myId");
    console.log(myId);

    fetch('/header')
        .then(response => response.text())
        .then(data => {
            document.getElementById('header-placeholder').innerHTML = data;

            const hamburger = document.querySelector('.hamburger');
            const mainNav = document.querySelector('.main-nav');
            console.log("hamburger");
            hamburger.addEventListener('click', function () {
                mainNav.classList.toggle('active');
            });

            const notificationLink = document.getElementById('notification-link');
            notificationLink.addEventListener('click', function (event) {
                event.preventDefault(); // 防止預設行為

                console.log("Notification clicked");
                // 顯示沒有通知的訊息
                displayNoNotifications();
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

            const rematchLink = document.getElementById('rematch-link');
            rematchLink.addEventListener('click', function (event) {
                event.preventDefault(); // Prevent default link behavior
                window.location.href = '/rental-form'; // Redirect to the rental form
            });

        });

    function displayNoNotifications() {
        // 檢查是否已經有通知框
        inviteMessage = document.querySelector('.notification-box');
        if (!inviteMessage) {
            inviteMessage = document.createElement('div');
            inviteMessage.classList.add('notification-box');
            inviteMessage.innerHTML = `
            <div class="notification-header">
                <span>通知</span>
                <button class="close-button">&times;</button>
            </div>
            <p>沒有新的通知</p>
        `;
            document.getElementById('header-placeholder').appendChild(inviteMessage);

            // 為關閉按鈕添加事件
            inviteMessage.querySelector('.close-button').addEventListener('click', function () {
                inviteMessage.style.display = 'none'; // 隱藏通知框
            });
        } else {
            // 如果已經有通知框，只是隱藏狀態，那麼顯示它
            inviteMessage.style.display = 'block';
        }
    }


    fetch(`/api/1.0/users/${myId}/name`)
        .then(response => response.text())
        .then(name => {
            console.log("name");
            console.log(name);
            console.log("document.getElementById('welcome-message')");
            console.log(document.getElementById('welcome-message'));
            document.getElementById('welcome-message').textContent = '您好，' + name;
        });

})
;


