import React, { useEffect, useState } from 'react';

import HeaderBoxAuth from '../../Components/HeaderBoxAuth';
import HeaderMainPage from '../../Components/HeaderMainPage';
import HeartAnimal from '../../Assets/HeartAnimal.svg';

import { isAuthenticated, login } from '../../Services/auth';
// import api from '../../Services/api';

import './styles.css';

export default function LogIn(props) {
  const INITIAL_STATE = {
    email: '',
    password: '',
  }
  const [user, setUser] = useState(INITIAL_STATE);
  const [error, setError] = useState('');

  useEffect(() => {
    if (isAuthenticated()) {
      props.history.push('/dashboard');
    }
  }, [props.history])

  async function handleLogin(e) {
    e.preventDefault();
    const { email, password } = user;

    if (!(email.includes('@') && email.includes('.com'))) {
      setError("This email is not valid");
      return;
    }

    if (password.length > 35) {
      setError("This email is not valid");
      return;
    }
    login("12345678");
    props.history.push('/dashboard');

    // await api.post("/company-auth/login", JSON.stringify(user)).then(res => {
    //    login(res.data.accessToken);
    //   props.history.push('/login');
    // }).catch(error => {
    //   switch (error.message) {
    //     case "Network Error":
    //       return setError("The server is temporarily turned off");
    //     case "Request failed with status code 404":
    //       return setError("There is no company associated with this email..");
    //     case "Request failed with status code 401":
    //       return setError("Incorrect email or password.");
    //     default:
    //       return setError("");
    //   }
    // })
  }

  return (
    <>
      <HeaderMainPage hideBtns={true} />
      <div className="container-login">
        <div className="content-login-page">
          <div className="box-login">
            <HeaderBoxAuth message="Login to PetCare" />
            <form className="login-form" onSubmit={handleLogin} autoComplete="off">
              <div className="error-area">
                <h3 className="error-login">{error}</h3>
              </div>
              <div className="input-area">
                <label>Email:</label>
                <div className="input-div">
                  <input type="text" name="email" onChange={e => setUser({ ...user, email: e.target.value })} />
                </div>
              </div>
              <div className="input-area">
                <label>Password:</label>
                <div className="input-div">
                  <input type="password" name="password" onChange={e => setUser({ ...user, password: e.target.value })} autoComplete="on" />
                </div>
              </div>
              <div className="button-area">
                <button type="submit">Login</button>
              </div>
            </form>
          </div>
          <div className="box-ref-signup">
            <div className="content-signup-box">
              <div className="header-ref-signup">
                <span>Don't have an account?</span>
              </div>
              <div className="button-signup-area">
                <a href="/register">Register</a>
              </div>
            </div>
          </div>
        </div>
        <div className="icon-image">
          <img src={HeartAnimal} alt="Pet Care Business" />
        </div>
      </div>
    </>
  );
}
