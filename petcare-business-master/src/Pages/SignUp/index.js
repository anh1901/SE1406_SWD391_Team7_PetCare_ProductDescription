import React, { useEffect } from 'react';

import HeaderMainPage from '../../Components/HeaderMainPage';
import HeaderBoxAuth from '../../Components/HeaderBoxAuth';
import Input from '../../Components/Input';
import ButtonForm from '../../Components/ButtonForm';

import { isAuthenticated } from '../../Services/auth';
import { addAnimationToInput } from '../../Helpers/Functions';

import api from '../../Services/api';
import { useSelector, useDispatch } from 'react-redux';
import { addErrors, addInput, changePhase } from '../../Store/Actions/Register';

import './styles.css';

export default function SignUp(props) {
  const state = useSelector(state => state.Register);
  const dispatch = useDispatch();

  useEffect(() => {
    let stateLocal = localStorage.getItem('state');
    if (stateLocal !== null && stateLocal.phase !== 1) {
      localStorage.removeItem('state');
    }

    if (isAuthenticated()) {
      props.history.push('/');
    }
  }, [props.history]);

  async function handleSubmit(e) {
    e.preventDefault();
    const { completeName, email, phoneNumber } = state.registerUser;
    if (!completeName || !email || !phoneNumber) {
      dispatch(addErrors("Fill in all data to register "));
      addAnimationToInput();
    } else {
      if (completeName.length <= 0 || completeName.length > 197) {
        dispatch(addErrors("Please enter a valid full name. "));
        addAnimationToInput();
        return;
      }

      if (!(email.includes('@') && email.includes('.com'))) {
        dispatch(addErrors("This email is not valid "));
        addAnimationToInput();
        return;
      }

      if (phoneNumber < 0 || phoneNumber.length > 20 || phoneNumber.length < 8) {
        dispatch(addErrors("This phone number is not valid. "));
        addAnimationToInput();
        return;
      }

      await api.post("/company-auth/validate-owner-email/", email).then(() => {
        dispatch(addErrors(''));
        dispatch(changePhase(2));
        localStorage.setItem('state', JSON.stringify(state.registerUser));
        props.history.push('/create-petshop')
      }).catch(error => {
        switch (error.message) {
          case "Network Error":
            return dispatch(addErrors("The server is temporarily turned off"));
          case "Request failed with status code 403":
            return dispatch(addErrors("This email is already in use. "));
          default:
            return dispatch(addErrors(""));
        }
      });
    }
  }

  return (
    <>
      <HeaderMainPage hideBtns={true} />
      <div className="container-signup">
        <div className="box-signup">
          <HeaderBoxAuth message="Sign up for PetCare" />
          <form className="signup-form" onSubmit={handleSubmit} autoComplete="off" autoCapitalize="off" autoCorrect="off">
            <div className="error-area">
              <h3 className="error-signup">{state.error}</h3>
            </div>
            <div className="input-area">
              <label>Full name: </label>
              <Input type="text" name="completeName" onChange={e => dispatch(addInput('ADD_COMPLETE_NAME', e.target.value))} messageBottom="It must be the full name of the business owner." />
            </div>
            <div className="input-area">
              <label>Email: </label>
              <Input type="text" name="email" onChange={e => dispatch(addInput('ADD_EMAIL', e.target.value))} messageBottom="This will be the email to enter the company. You can add your company name later." />
            </div>
            <div className="input-area">
              <label>Telephone: </label>
              <Input type="text" name="phoneNumber" onChange={e => dispatch(addInput('ADD_PHONENUMBER', e.target.value))} messageBottom="Phone to contact the company." />
            </div>
            <ButtonForm text="Register" />
          </form>
        </div>
        <div className="box-ref-login">
          <div className="content-login-box">
            <div className="header-ref-login">
              <span>Already have a registered company?</span>
            </div>
            <div className="button-login-area">
              <a href="/login">Login</a>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
