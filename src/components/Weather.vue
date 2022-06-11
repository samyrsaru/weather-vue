<script setup lang="ts">
import { ref, watchEffect } from 'vue'

const props = defineProps(['cityName'])
// const cityName = computed(() => props.cityName);
// const cityName = ref(props.cityName);

const weatherData = ref(null);

const fetchWeather = () => {
    console.log("fetchWeather", props, props.cityName, props.cityName);
    if (!props.cityName) return;
    const [city, country] = props.cityName.toLowerCase().split(',').map(word => word.trim());
    if (!city) return;

    console.log("fetchWeather ---");

    const options = {
        method: 'GET',
        headers: {
            'X-RapidAPI-Key': '202c8b39b2msh36c251a5db0894ep11c028jsn65d4f3ccce12',
            'X-RapidAPI-Host': 'community-open-weather-map.p.rapidapi.com'
        }
    };

    fetch(`https://community-open-weather-map.p.rapidapi.com/forecast?q=${city}%2C${country}&units=metric`, options)
        .then(response => response.json())
        .then(response => {
            console.log(response);
            weatherData.value = response;
            // weatherData.value = response.cod === "200" ? response : null;
        })
        .catch(err => {
            console.error(err);
            weatherData.value = null;
        });
}

const getDayOfWeek = (day) => {
    let dayIntToString = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return dayIntToString[day];
}

watchEffect(() => fetchWeather());

</script>

<template>
    <div class="p-5">
        <div v-if="weatherData" class="pt-5">
            <div v-if="weatherData.cod === '200'">
                <div class="flex flex-col w-fit mb-4">
                    <h1 class="text-6xl mb-2">{{weatherData.city.name}}</h1>
                    <p class="flex justify-between">
                        <span>Sunrise:</span>
                        <span>{{new Date(weatherData.city.sunrise * 1000).toLocaleTimeString()}}</span>
                    </p>
                    <p class="flex justify-between">
                        <span>Sunset:</span>
                        <span>{{new Date(weatherData.city.sunset * 1000).toLocaleTimeString()}}</span>
                    </p>
                </div>
                <div v-for="value in weatherData.list"
                    class="grid grid-cols-3 md:grid-cols-5 mb-4 place-items-center
                        bg-gray-800 px-4 py-2
                        border-l-gray-500 border-l-4
                    "
                >
                    <p class="place-self-start self-center">{{
                            new Date(value.dt_txt).getDate() + " (" +
                            getDayOfWeek(new Date(value.dt_txt).getDay()) + ")  " +
                            (new Date(value.dt_txt).getHours() + "").padStart(2, "0")
                        }}
                    </p>
                    <span class="flex items-center text-xl">
                        <img v-if="true" v-bind:src="`https://openweathermap.org/img/wn/${value.weather[0].icon}.png`"/>
                        <span class="">{{Math.floor(value.main.temp)}}°</span>
                    </span>
                    <span class="flex items-center gap-1">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-moisture" viewBox="0 0 16 16">
                            <path d="M13.5 0a.5.5 0 0 0 0 1H15v2.75h-.5a.5.5 0 0 0 0 1h.5V7.5h-1.5a.5.5 0 0 0 0 1H15v2.75h-.5a.5.5 0 0 0 0 1h.5V15h-1.5a.5.5 0 0 0 0 1h2a.5.5 0 0 0 .5-.5V.5a.5.5 0 0 0-.5-.5h-2zM7 1.5l.364-.343a.5.5 0 0 0-.728 0l-.002.002-.006.007-.022.023-.08.088a28.458 28.458 0 0 0-1.274 1.517c-.769.983-1.714 2.325-2.385 3.727C2.368 7.564 2 8.682 2 9.733 2 12.614 4.212 15 7 15s5-2.386 5-5.267c0-1.05-.368-2.169-.867-3.212-.671-1.402-1.616-2.744-2.385-3.727a28.458 28.458 0 0 0-1.354-1.605l-.022-.023-.006-.007-.002-.001L7 1.5zm0 0-.364-.343L7 1.5zm-.016.766L7 2.247l.016.019c.24.274.572.667.944 1.144.611.781 1.32 1.776 1.901 2.827H4.14c.58-1.051 1.29-2.046 1.9-2.827.373-.477.706-.87.945-1.144zM3 9.733c0-.755.244-1.612.638-2.496h6.724c.395.884.638 1.741.638 2.496C11 12.117 9.182 14 7 14s-4-1.883-4-4.267z"/>
                        </svg> 
                        {{Math.floor(value.main.humidity)}}%
                    </span>
                    <span class="block md:hidden"></span>
                    <span>&#9748; {{Math.floor(value.pop * 100)}}%</span>
                    <span>{{value.weather[0].description}}</span>
                </div>
            </div>
            <div v-else>
                <p class="text-2xl">{{weatherData.message.charAt(0).toUpperCase() + weatherData.message.slice(1)}}</p>
            </div>
        </div>
        <div v-else class="pt-5">
            <p class="text-2xl">Search for a city!</p>
        </div>
    </div>
</template>

