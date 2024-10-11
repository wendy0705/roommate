let currentUserId = null;
let notificationSocket = null;
let websocketUrl;
let chatServiceHost;
let inviteMessage = null;
let hasPendingInvitation = false;

window.addEventListener('load', function () {
    currentUserId = sessionStorage.getItem('myId');
    currentUserId = BigInt(currentUserId);
    websocketUrl = sessionStorage.getItem('websocketUrl');
    chatServiceHost = sessionStorage.getItem('chatServiceHost');
    console.log(websocketUrl);

    console.log("window.addEventListener('load', function ()");

    if (!currentUserId) {
        console.log("No user ID found in sessionStorage. Cannot connect to WebSocket.");
        return;
    }
    checkInvitationStatus();

    // 自動建立 WebSocket 來接收通知
    notificationSocket = new WebSocket(`${websocketUrl}/notifications?userId=${currentUserId}`);

    notificationSocket.onmessage = function (event) {
        const data = JSON.parse(event.data);
        console.log("notification socket" + data.type);

        if (data.type === "invitation") {
            // 當接收到邀請消息時，顯示接受或拒絕邀請的按鈕
            console.log("receive invitation");
            showInvitation(data.inviter_id, data.invitee_id);
        } else if (data.type === "accepted") {
            // 當接收到邀請已被接受的通知時，更新按鈕狀態
            console.log(`Your invitation was accepted by user ${data.invitee_id}.`);
            const button = document.querySelector(`.invite-button[data-invitee-id="${data.invitee_id}"]`);
            if (button) {
                button.classList.remove('invitation-sent');
                button.classList.add('chat-button');
                button.textContent = '跟他聊聊';
                button.disabled = false;

                button.replaceWith(button.cloneNode(true));

                // 重新選取新的按鈕元素，並綁定新的事件來打開聊天
                const newButton = document.querySelector(`.invite-button[data-invitee-id="${data.invitee_id}"]`);
                // 修改這裡，只傳遞 otherUserId 和 currentUserId
                newButton.addEventListener('click', () => startChat(data.invitee_id, currentUserId));
            }

            updateChatroomList();
        } else if (data.type === "declined") {
            console.log(`Your invitation was declined by user ${data.invitee_id}.`);
            const button = document.querySelector(`.invite-button[data-invitee-id="${data.invitee_id}"]`);
            if (button) {
                button.classList.remove('invitation-sent', 'chat-button');
                button.textContent = '邀請聊聊';
                button.disabled = false;
            }
        }
    };

    notificationSocket.onerror = function (error) {
        console.error('WebSocket error:', error);
    };

    notificationSocket.onopen = function () {
        console.log('Notification WebSocket connected for user ID: ' + currentUserId);
    };
});

function updateChatroomList() {
    const chatroomList = document.getElementById('chatroom-list');
    chatroomList.style.display = 'block';

    getChatRoomsForCurrentUser().then(chatRooms => {
        console.log(chatRooms);
        chatroomList.innerHTML = '';  // 清空之前的列表
        chatRooms.forEach(otherUserId => {
            
            const roomElement = document.createElement('div');
            roomElement.className = 'chatroom-item';
            roomElement.textContent = `與${otherUserId}的聊天室`;
            roomElement.addEventListener('click', function () {
                // 修改這裡，只傳遞 otherUserId 和 currentUserId
                startChat(otherUserId, currentUserId);  // 點擊後進入該聊天室
            });
            chatroomList.appendChild(roomElement);
        });
    });
}

function getChatRoomsForCurrentUser() {
    return fetch(`${chatServiceHost}/chat/chatrooms?userId=${currentUserId}`)
        .then(response => response.json())
        .then(data => {
            console.log("get chatrooms for current users", data);
            return data;
        })
        .catch(error => {
            console.error('Error fetching chat rooms:', error);
            return [];
        });
}

// 顯示邀請按鈕的邏輯
function showInvitation(inviterId, inviteeId) {
    // 顯示紅點
    const notificationDot = document.getElementById('notification-dot');
    notificationDot.style.display = 'inline-block';

    // 點擊通知時打開通知框
    document.getElementById('notification-link').addEventListener('click', function () {
        // 隱藏紅點
        notificationDot.style.display = 'none';

        // 創建並顯示通知框
        if (!document.querySelector('.notification-box')) {
            inviteMessage = document.createElement('div');
            inviteMessage.classList.add('notification-box');
            inviteMessage.innerHTML = `
                <div class="notification-header">
                    <span>通知</span>
                    <button class="close-button">&times;</button>
                </div>
                <p>You have a new chat invitation from User ${inviterId}. Do you want to accept?</p>
                <button id="acceptBtn">Accept</button>
                <button id="declineBtn">Decline</button>
            `;
            document.getElementById('header-placeholder').appendChild(inviteMessage);

            document.querySelector('.close-button').addEventListener('click', function () {
                inviteMessage.style.display = 'none'; // 隱藏通知框
            });

            // 處理接受邀請的邏輯
            document.getElementById('acceptBtn').addEventListener('click', function () {
                acceptInvitation(inviterId, inviteeId);
                inviteMessage.style.display = 'none';
                hasPendingInvitation = false;
            });

            // 處理拒絕邀請的邏輯
            document.getElementById('declineBtn').addEventListener('click', function () {
                declineInvitation(inviterId, inviteeId);
                inviteMessage.style.display = 'none';
                hasPendingInvitation = false;
            });
        } else {
            if (inviteMessage.style.display === 'none') {
                if (hasPendingInvitation) {
                    inviteMessage.style.display = 'block'; // 顯示未處理的邀請
                } else {
                    displayNoNotifications(); // 顯示「沒有新的通知」
                }
            } else {
                inviteMessage.style.display = 'block';
            }
        }
    });
}

function displayNoNotifications() {
    if (inviteMessage) {
        inviteMessage.innerHTML = `
            <div class="notification-header">
                <span>通知</span>
                <button class="close-button">&times;</button>
            </div>
            <p>沒有新的通知</p>
        `;
        inviteMessage.style.display = 'block'; // 顯示通知框

        // 關閉按鈕的處理
        document.querySelector('.close-button').addEventListener('click', function () {
            inviteMessage.style.display = 'none'; // 隱藏通知框
        });
    }
}

function checkInvitationStatus() {
    const storedResults = sessionStorage.getItem('matchResults');
    if (!storedResults) {
        alert('無匹配結果可調整');
        return;
    }
    const parsedResults = JSON.parse(storedResults);
    const userIds = parsedResults.map(item => item.userId);

    const payload = {
        myId: currentUserId.toString(),
        userIds: userIds
    };

    fetch(`${chatServiceHost}/chat/invitation-status`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
    })
        .then(response => response.json())
        .then(data => {
            data.forEach(statusObj => {
                const {userId, status} = statusObj;
                const button = document.querySelector(`.invite-button[data-invitee-id="${userId}"]`);
                if (button) {
                    if (status === 'pending') {
                        button.classList.add('invitation-sent');
                        button.textContent = '邀請已發送';
                        button.disabled = true;
                    } else if (status === 'accepted') {
                        button.classList.remove('invitation-sent');
                        button.classList.add('chat-button');
                        button.textContent = '跟他聊聊';
                        button.disabled = false;

                        button.replaceWith(button.cloneNode(true));

                        // 修改這裡，只傳遞 otherUserId 和 currentUserId
                        const newButton = document.querySelector(`.invite-button[data-invitee-id="${userId}"]`);
                        newButton.addEventListener('click', () => startChat(userId, currentUserId));

                        updateChatroomList();
                    } else if (status === 'declined') {
                        button.classList.remove('invitation-sent', 'chat-button');
                        button.textContent = '邀請聊聊';
                        button.disabled = false;
                    }
                }
            });
        })
        .catch(error => {
            console.error('Error checking invitation status:', error);
        });
}

function acceptInvitation(inviterId, inviteeId) {
    fetch(`${chatServiceHost}/chat/accept`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({inviter_id: inviterId, invitee_id: inviteeId})
    })
        .then(response => response.text())
        .then(data => {
            console.log(data);
            // 修改這裡，只傳遞 otherUserId 和 currentUserId
            startChat(inviterId, currentUserId);
        })
        .catch(error => {
            console.error('Error accepting invitation:', error);
        });
}

// Decline invitation
function declineInvitation(inviterId, inviteeId) {
    fetch(`${chatServiceHost}/chat/decline`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({inviterId: inviterId, inviteeId: inviteeId})
    })
        .then(response => response.text())
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.error('Error declining invitation:', error);
        });
}

function startChat(otherUserId, currentUserId) {
    console.log(`Starting chat with user ${otherUserId}`);
    const sortedIds = [otherUserId, currentUserId].sort();
    const roomName = `${sortedIds[0]}_${sortedIds[1]}`;

    const chatWrapper = document.querySelector('.chat-wrapper');
    chatWrapper.style.display = 'block';

    const socket = new WebSocket(`${websocketUrl}/chat?userId=${currentUserId}&roomName=${roomName}`);

    socket.onopen = function () {
        console.log('WebSocket connection established');
        addMessage('系統', `已連接到聊天室: ${roomName}`, 'system');
    };

    socket.onmessage = function (event) {
        addMessage('對方', event.data, 'received');
    };

    socket.onerror = function (error) {
        console.error('WebSocket error:', error);
        addMessage('系統', '連接錯誤，請稍後再試。', 'system');
    };

    // 移除之前的事件監聽器以避免多次綁定
    const sendMessageBtn = document.getElementById('sendMessageBtn');
    const messageInput = document.getElementById('messageInput');
    sendMessageBtn.removeEventListener('click', sendMessage);
    messageInput.removeEventListener('keypress', handleKeyPress);

    sendMessageBtn.addEventListener('click', sendMessage);
    messageInput.addEventListener('keypress', handleKeyPress);

    function sendMessage() {
        const message = messageInput.value.trim();
        if (message) {
            socket.send(message);
            addMessage('你', message, 'sent');
            messageInput.value = '';
        }
    }

    function handleKeyPress(e) {
        if (e.key === 'Enter') {
            sendMessage();
        }
    }

    function addMessage(sender, text, type) {
        const messagesDiv = document.getElementById('messages');
        const messageDiv = document.createElement('div');
        messageDiv.className = `message ${type}`;
        messageDiv.innerHTML = `<strong>${sender}:</strong> ${text}`;
        messagesDiv.appendChild(messageDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }
}
