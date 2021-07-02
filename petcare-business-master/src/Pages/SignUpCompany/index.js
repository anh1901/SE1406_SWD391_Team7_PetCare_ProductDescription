import React, { useEffect } from 'react';

import HeaderMainPage from '../../Components/HeaderMainPage';
import HeaderBoxAuth from '../../Components/HeaderBoxAuth';
import Input from '../../Components/Input';
import ButtonForm from '../../Components/ButtonForm';

import { addAnimationToInput } from '../../Helpers/Functions';

import api from '../../Services/api';
import { useSelector, useDispatch } from 'react-redux';
import { addErrors, addInput, changePhase, addState } from '../../Store/Actions/Register';

import './styles.css';

export default function SignUpPhaseTwo(props) {
  const stateSignUp = useSelector(state => state.Register);
  const dispatch = useDispatch();
  const registerUserLocalStorage = JSON.parse(localStorage.getItem('state'));

  useEffect(() => {
    if (registerUserLocalStorage === null) {
      props.history.push('/register');
    }
  }, [props.history, registerUserLocalStorage]);

  async function handleSubmit(e) {
    e.preventDefault();
    const { cnpj, companyName } = stateSignUp.registerUser;
    const { street, placeNumber, complement, neighborhood, cep, city, state } = stateSignUp.registerUser.address;
    if (!cnpj || !companyName || !street || !placeNumber || !neighborhood || !cep || !city || !state) {
      dispatch(addErrors("Fill in all data to continue registration"));
      addAnimationToInput();
    } else {
      if (cnpj < 14 || cnpj.length > 18) {
        dispatch(addErrors("CNPJ is invalid, please enter a correct one."));
        addAnimationToInput();
        return;
      }

      if (companyName.length <= 0 || companyName.length > 250) {
        dispatch(addErrors("Please enter a valid name"));
        addAnimationToInput();
        return;
      }

      if (street.length > 250) {
        dispatch(addErrors("Invalid street"));
        addAnimationToInput();
        return;
      }

      if (placeNumber < 0 || placeNumber > 20000) {
        dispatch(addErrors("Invalid number"));
        addAnimationToInput();
        return;
      }

      if (complement.length >= 100) {
        dispatch(addErrors("Very extensive complement"));
        addAnimationToInput();
        return;
      }

      if (neighborhood.length > 250) {
        dispatch(addErrors("Invalid neighborhood"));
        addAnimationToInput();
        return;
      }

      if (cep.length > 9) {
        dispatch(addErrors("Invalid zip code"));
        addAnimationToInput();
        return;
      }

      if (state.length > 4) {
        dispatch(addErrors("Invalid state"));
        addAnimationToInput();
        return;
      }

      await api.post("/company-auth/validate-cnpj", cnpj).then(() => {
        const mergeState = {
          completeName: registerUserLocalStorage.completeName,
          email: registerUserLocalStorage.email,
          phoneNumber: registerUserLocalStorage.phoneNumber,
          cnpj: stateSignUp.registerUser.cnpj,
          companyName: stateSignUp.registerUser.companyName,
          address: { ...stateSignUp.registerUser.address },
          description: "",
          cpf: "",
          password: "",
        }
        const { completeName, email, phoneNumber } = stateSignUp.registerUser;
        if (!completeName || !email || !phoneNumber) {
          dispatch(addState(mergeState));
        }
        dispatch(addErrors(''));
        dispatch(changePhase(3));
        localStorage.setItem('state', JSON.stringify(mergeState));
        props.history.push('/finish')
      }).catch(error => {
        switch (error.message) {
          case "Network Error":
            return dispatch(addErrors("The server is temporarily turned off"));
          case "Request failed with status code 403":
            return dispatch(addErrors("This CNPJ is already being used"));
          default:
            return dispatch(addErrors(""));
        }
      });
    }
  }

  return (
    <>
      <HeaderMainPage hideBtns={true} />
      <div className="container-signup-phasetwo">
        <HeaderBoxAuth message="About the pet shop" />
        <form className="signup-phasetwo" onSubmit={handleSubmit} autoComplete="off" autoCapitalize="off" autoCorrect="off">
          <div className="error-area">
            <h3 className="error-signup">{stateSignUp.error}</h3>
          </div>
          <Input type="text" placeholder="CNPJ" onChange={e => dispatch(addInput('ADD_CNPJ', e.target.value))} messageBottom="CNPJ must be from the pet shop that is registered" />
          <Input type="text" placeholder="Name of pet store" onChange={e => dispatch(addInput('ADD_COMPANY_NAME', e.target.value))} messageBottom="This name visible to the customer, and in the company profile" />
          <Input type="text" placeholder="Address" onChange={e => dispatch(addInput('ADD_STREET', e.target.value))} />
          <Input type="number" placeholder="Number" onChange={e => dispatch(addInput('ADD_PLACENUMBER', e.target.value))} max="100000.00" />
          <Input type="text" placeholder="Complement (Optional)" onChange={e => dispatch(addInput('ADD_COMPLEMENT', e.target.value))} />
          <Input type="text" placeholder="Neighborhood" onChange={e => dispatch(addInput('ADD_NEIGHBORHOOD', e.target.value))} />
          <Input type="text" placeholder="Zip code" onChange={e => dispatch(addInput('ADD_CEP', e.target.value))} />
          <div className="city-states">
            <div className="city-input inputed">
              <input type="text" placeholder="City" onChange={e => dispatch(addInput('ADD_CITY', e.target.value))} />
            </div>
            <div className="states inputed">
              <input type="text" placeholder="State" onChange={e => dispatch(addInput('ADD_STATES', e.target.value))} />
            </div>
          </div>
          <ButtonForm text="Continue registration" />
        </form>
      </div>
    </>
  );
}
