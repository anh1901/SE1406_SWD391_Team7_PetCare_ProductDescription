import React, { useEffect } from 'react';

import HeaderMainPage from '../../Components/HeaderMainPage';

import dog from "../../Assets/dog-main.png";
import cat from "../../Assets/cat-main.jpg";

import { isAuthenticated } from '../../Services/auth';

import './styles.css';

export default function Main(props) {

  useEffect(() => {
    if (isAuthenticated()) {
      props.history.push('/login')
    }
  }, [props.history])

  return (
    <>
      <HeaderMainPage />
      <div className="body-main">
        <div className="container-main">
          <div className="banner-main-dog">
            <img src={dog} alt="" />

            <div className="banner-h1">
              <h1>For the sake of your pet's well-being!</h1>
            </div>

            <div className="banner-p">
              <p>Your friend's happiness is just a click away</p>
              <a href="/login">Create your account</a>
            </div>
          </div>
          <div className="banner-main-cat">
            <img src={cat} alt="" />
            <div className="banner-h1-cat">
              <h1>Come make a difference!</h1>
            </div>
            <div className="banner-p-cat">
              <p>Join the PetCare</p>
            </div>
            <a href="/register">Register your company</a>
          </div>
        </div>
      </div>
    </>
  );
}
