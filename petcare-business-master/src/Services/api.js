import axios from 'axios';
import { getToken } from "./auth";

const api = axios.create({
  //baseURL: 'https://aw-petcare-api.herokuapp.com/api',
  baseURL: process.env.REACT_APP_API_URL,
  headers: { 'Content-Type': 'application/json' },
});

api.interceptors.request.use(async config => {
  const token = getToken();
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default api;