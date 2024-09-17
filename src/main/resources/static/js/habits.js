document.addEventListener("DOMContentLoaded", function () {
    fetchHabits();
});

function fetchHabits() {
    fetch(`data/similarity`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            "share_room": 1,
            "special_conditions": {
                "haunted_house": 0,
                "rooftop_extension": 1,
                "illegal_building": 0,
                "basement": 0,
                "windowless": 1
            },
            "schedule": {
                "monday": [0, 11],
                "tuesday": [23, 6],
                "wednesday": [23, 6],
                "thursday": [23, 6],
                "friday": [23, 6],
                "saturday": [1, 8],
                "sunday": [1, 8]
            },
            "cooking_location": 1,
            "dining_location": 0,
            "dining_habits": {
                "alone": 1,
                "not_alone": 0
            },
            "noise_sensitivity": {
                "sleep": 5,
                "study_or_work": 3
            },
            "alarm_habit": 1,
            "light_sensitivity": 2,
            "friendship_habit": 1,
            "hot_weather_preference": {
                "preference": 3,
                "temperature": 24
            },
            "humidity_preference": 2,
            "pet": {
                "has_pet": 1,
                "pet_type": "狗"

            }
        })
    }).then(response => {
        if (response.ok) {
            return response.json();
        } else {
            throw new Error('加載失敗');
        }
    }).then(data => {
        console.log(data.data);
    }).catch(error => {
        console.error('Error fetching revenue', error);
    });
}