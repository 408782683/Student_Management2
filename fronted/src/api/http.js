import axios from 'axios';

const http = axios.create({
  baseURL: '/api'
});

http.interceptors.response.use(
  (resp) => resp,
  (error) => {
    const msg = error.response?.data?.message || error.message;
    alert(msg);
    return Promise.reject(error);
  }
);

export default http;
