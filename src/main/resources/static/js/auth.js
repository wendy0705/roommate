document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('loginForm');
    const signupForm = document.getElementById('signupForm');
    const switchForms = document.querySelectorAll('.switch-form');

    switchForms.forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            const formToShow = this.getAttribute('data-form');
            document.querySelector('.form-box.login').classList.toggle('hidden');
            document.querySelector('.form-box.signup').classList.toggle('hidden');
        });
    });

    loginForm.addEventListener('submit', function (e) {
        e.preventDefault();
        const email = this.querySelector('input[type="email"]').value;
        const password = this.querySelector('input[type="password"]').value;

        const formData = {
            email: email,
            password: password
        };

        fetch('/api/1.0/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.token) {
                    sessionStorage.setItem('jwtToken', data.token);
                    console.log('Token stored:', data.token);
                    alert("登入成功！");
                    const token = sessionStorage.getItem('jwtToken');

                    fetch('/mainpage', {
                        method: 'GET',
                        headers: {
                            'Authorization': `Bearer ${token}`
                        }
                    })
                        .then(response => {
                            if (response.ok) {
                                window.location.href = "/mainpage";
                            } else {
                                alert("無法載入主頁面");
                                console.error("Failed to load mainpage", response);
                            }
                        })
                        .catch(error => {
                            console.error('Error fetching mainpage:', error);
                        });

                } else {
                    alert("登入失敗");
                    console.error('Token not received:', data);
                }
            })
            .catch(error => {
                alert('登入失敗，請再試一次！');
            });

    });

    signupForm.addEventListener('submit', function (e) {
        e.preventDefault();
        const lastName = document.getElementById('lastName').value;
        const gender = document.querySelector('input[name="gender"]:checked').value;

        // 組合姓名 (如：王小姐)
        const fullName = `${lastName}${gender}`;

        // 創建一個要提交的資料物件
        const formData = {
            name: fullName,
            email: document.querySelector('#signupForm input[type="email"]').value,
            password: document.querySelector('#signupForm input[type="password"]').value
        };

        fetch('/api/1.0/auth/signup', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.token) {
                    sessionStorage.setItem('jwtToken', data.token);
                    console.log('Token stored:', data.token);
                    const token = sessionStorage.getItem('jwtToken');

                    fetch('/mainpage', {
                        method: 'GET',
                        headers: {
                            'Authorization': `Bearer ${token}`
                        }
                    })
                        .then(response => {
                            if (response.ok) {
                                window.location.href = "/mainpage";
                            } else {
                                alert("無法載入主頁面");
                                console.error("Failed to load mainpage", response);
                            }
                        })
                        .catch(error => {
                            console.error('Error fetching mainpage:', error);
                        });

                } else {
                    alert("註冊失敗");
                    console.error('Token not received:', data);
                }
            })
            .catch(error => {
                // 捕獲錯誤，彈出 alert
                alert('註冊失敗，請再試一次！');
                console.error('Error during signup:', error);
            });
    });

});