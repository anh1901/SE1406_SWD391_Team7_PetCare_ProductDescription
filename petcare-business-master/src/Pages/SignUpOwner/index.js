import React, { useEffect, useState } from 'react';

import HeaderMainPage from '../../Components/HeaderMainPage';
import HeaderBoxAuth from '../../Components/HeaderBoxAuth';
import Input from '../../Components/Input';
import ButtonForm from '../../Components/ButtonForm';

import { addAnimationToInput } from '../../Helpers/Functions';

import api from '../../Services/api';
import { useSelector, useDispatch } from 'react-redux';
import { addErrors, addInput, changePhase, addState } from '../../Store/Actions/Register';

import './styles.css';

export default function SignUpOwner(props) {
  const stateSignUp = useSelector(state => state.Register);
  const dispatch = useDispatch();
  const stateLocal = JSON.parse(localStorage.getItem('state'));
  let completeNameLocal = '';
  if (stateLocal !== null) { completeNameLocal = stateLocal.completeName }
  const [completeNameState, setCompleteNameState] = useState(completeNameLocal);

  useEffect(() => {
    if (stateLocal === null) {
      props.history.push('/register');
    }
  }, [props.history, stateLocal]);



  async function handleSubmit(e) {
    e.preventDefault();
    const { cpf, password } = stateSignUp.registerUser;
    if (!completeNameState || !cpf || !password) {
      dispatch(addErrors("Fill in all data to continue registration"));
      addAnimationToInput();
    } else {
      dispatch(addErrors(""));
      if (completeNameState.length <= 0 || completeNameState.length > 1000) {
        dispatch(addErrors("Invalid full name " + completeNameState));
        addAnimationToInput();
        return;
      }

      let cpfWithoutPonto = cpf;
      if (cpfWithoutPonto.includes(".")) {
        cpfWithoutPonto = cpfWithoutPonto.split(".").join("");
      }
      if (cpfWithoutPonto.includes("-")) {
        cpfWithoutPonto = cpfWithoutPonto.split("-").join("");
      }

      if (cpfWithoutPonto.length > 11) {
        dispatch(addErrors("This CPF is invalid, please enter a valid one"));
        addAnimationToInput();
        return;
      }

      var Soma;
      var Resto;
      Soma = 0;
      if (cpfWithoutPonto === "00000000000") {
        dispatch(addErrors("This CPF is invalid, please enter a valid one"));
        addAnimationToInput();
        return;
      }

      for (var i = 1; i <= 9; i++) Soma = Soma + parseInt(cpfWithoutPonto.substring(i - 1, i)) * (11 - i);
      Resto = (Soma * 10) % 11;

      if ((Resto === 10) || (Resto === 11)) Resto = 0;
      if (Resto !== parseInt(cpfWithoutPonto.substring(9, 10))) {
        dispatch(addErrors("This CPF is invalid, please enter a valid one"));
        addAnimationToInput();
        return;
      };

      Soma = 0;
      for (i = 1; i <= 10; i++) Soma = Soma + parseInt(cpfWithoutPonto.substring(i - 1, i)) * (12 - i);
      Resto = (Soma * 10) % 11;

      if ((Resto === 10) || (Resto === 11)) Resto = 0;
      if (Resto !== parseInt(cpfWithoutPonto.substring(10, 11))) {
        dispatch(addErrors("This CPF is invalid, please enter a valid one"));
        addAnimationToInput();
        return;
      }

      if (password.length <= 5 || password.length > 50) {
        dispatch(addErrors("Invalid password"));
        addAnimationToInput();
        return;
      }

      const mergeState = {
        completeName: stateLocal.completeName,
        email: stateLocal.email,
        phoneNumber: stateLocal.phoneNumber,
        cnpj: stateLocal.cnpj,
        companyName: stateLocal.companyName,
        address: { ...stateLocal.address },
        description: "",
        cpf: stateSignUp.registerUser.cpf,
        password: stateSignUp.registerUser.password,
      }
      dispatch(addState(mergeState));

      await api.post("/signup-petshop", JSON.stringify(stateSignUp.registerUser)).then(() => {
        dispatch(addErrors(''));
        dispatch(changePhase(3));
        localStorage.removeItem('state');
        props.history.push('/login')
      }).catch(error => {
        switch (error.message) {
          case "Network Error":
            return dispatch(addErrors("The server is temporarily turned off"));
          case "Request failed with status code 403":
            return dispatch(addErrors("This CPF is already being used"))
          default:
            return dispatch(addErrors(""));
        }
      });
    }
  }

  function handleCompleteName(e) {
    setCompleteNameState(e.target.value)
    const newStateWithNewName = { ...stateLocal, completeName: e.target.value }
    localStorage.setItem('state', JSON.stringify(newStateWithNewName));
  }

  // VALIDATE CPF
  function handleChangeCPFAndMask(cpf) {
    cpf = cpf.replace(/\D/g, '') 
      .replace(/(\d{3})(\d)/, '$1.$2') 
      .replace(/(\d{3})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d{1,2})/, '$1-$2')
      .replace(/(-\d{2})\d+?$/, '$1')
    dispatch(addInput('ADD_CPF', cpf));
  }

  return (
    <>
      <HeaderMainPage hideBtns={true} />
      <div className="container-signup-phasethree">
        <HeaderBoxAuth message="About the owner" />
        <form className="form-phasethree" onSubmit={handleSubmit} autoComplete="off" autoCapitalize="off" autoCorrect="off">
          <div className="error-area">
            <h3 className="error-signup">{stateSignUp.error}</h3>
          </div>
          <Input type="text" value={completeNameState} onChange={handleCompleteName} messageBottom="Full name of company owner" />
          <Input type="text" placeholder="CPF" value={stateSignUp.registerUser.cpf} onChange={e => handleChangeCPFAndMask(e.target.value)} messageBottom="The CPF must be that of the company owner" />
          <Input type="password" placeholder="Passowrd" onChange={e => dispatch(addInput('ADD_PASSWORD', e.target.value))} messageBottom="Password that will be used to enter the company's system" autoComplete="on" />
          <ButtonForm text="Finish" />
        </form>
      </div>
    </>
  );
}
