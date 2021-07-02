import React, { useEffect, useState } from 'react';

import HeaderEditPage from '../../Components/HeaderEditPage';
import SideBar from '../../Components/SideBar';
import Input from '../../Components/Input';
import InputFileImage from '../../Components/InputFileImage';
import TextArea from '../../Components/TextArea';
import ButtonForm from '../../Components/ButtonForm';

import api from '../../Services/api';
import { isAuthenticated } from '../../Services/auth';

import './styles.css';

export default function EditPage(props) {
  const INITIAL_STATE = {
    id: '',
    name: '',
    description: '',
    price: 0,
    quantityStore: 0,
    weight: '',
    indicationPet: '',
    postage: '',
    acts: '',
    transgenic: '',
    composition: '',
    avatar: '',
    filet: '',
  }
  const [product, setProduct] = useState(INITIAL_STATE);
  const [ImageShow, setImageShow] = useState('');
  const [errors, setErrors] = useState('');

  useEffect(() => {
    if (isAuthenticated()) {
      async function findProduct(id) {
        await api.get(`/products-list/${id}`).then(res => {
          setProduct(res.data);
          setImageShow(res.data.avatar);
        }).catch(error => {
          switch (error.message) {
            case "Network Error":
              return setErrors("The server is temporarily down");
            case "Request failed with status code 404":
              return setErrors("There is no product with this id.");
            case "Request failed with status code 403":
              return props.history.push("/login");
            default:
              return setErrors("");
          }
        });
      }
      if(props.match.params.id !== ":id") {
        findProduct(props.match.params.id);
      }
    } else {
      props.history.push('/login');
    }
  }, [props.history, props.match.params.id])

  async function handleSubmit(e) {
    e.preventDefault();
    const { name, description, price, indicationPet, postage, age, composition, quantityStore } = product;
    if (!name || !price || !indicationPet || !postage || !age || !quantityStore) {
      setErrors("Fill in all the data to register the product");
    } else {
      if (name === null || name === undefined || name.length > 65) {
        setErrors("Product name too long");
        return;
      }

      if (description === null || description === undefined || description.length >= 650) {
        setErrors("Description can only be a maximum of 650 characters");
        return;
      }

      if (price === null || price === undefined || price <= 0 || price === 20000.00) {
        setErrors("Price is not valid");
        return;
      }

      if (quantityStore === null || quantityStore === undefined || quantityStore <= 0 || quantityStore > 5000) {
        setErrors("Invalid quantity in stock");
        return;
      }

      if (indicationPet === null || indicationPet === undefined || indicationPet.length >= 100) {
        setErrors("Indication too long");
        return;
      }

      if (postage === null || postage === undefined || postage.length >= 50) {
        setErrors("Size too large");
        return;
      }

      if (age === null || age === undefined || age.length >= 35) {
        setErrors("Age too long");
        return;
      }

      if (composition === null || composition === undefined || composition.length >= 650) {
        setErrors("Composition too long");
        return;
      }

      let data = new FormData();
      data.append('name', product.name);
      data.append('description', product.description);
      data.append('price', product.price);
      data.append('weight', product.weight);
      data.append('indicationPet', product.indicationPet);
      data.append('porte', product.porte);
      data.append('age', product.age);
      data.append('transgenic', product.transgenic);
      data.append('composition', product.composition);
      data.append('quantityStore', product.quantityStore);
      data.append('avatar', product.avatar);
      data.append('file', product.file);

      await api.post(`/edit-product/${product.id}`, data).then(() => {
        props.history.push('/products');
      }).catch(error => {
        switch (error.message) {
          case "Network Error":
            return setErrors("The server is temporarily down");
          case "Request failed with status code 404":
            return setErrors("There is no product with this id.");
          case "Request failed with status code 403":
            return props.history.push("/login");
          default:
            return setErrors("");
        }
      });
    }
  }


  const [textImage, setTextImage] = useState('');

  function handleImage(e) {
    e.preventDefault();
    setProduct({ ...product, file: e.target.files[0] });
    setTextImage(e.target.files[0].name);
  }


  return (
    <>
      <SideBar props={props} />
      <div className="container-page-sidebar">
        <HeaderEditPage editPage={true} />
        <div className="container-form">
          <div className="product-info-edit-title">
            Edit product data
          </div>
          <span>{errors}</span>
          <form className="product-edit-form" onSubmit={handleSubmit}>
            <InputFileImage onChangeText={textImage} image={ImageShow} onChange={handleImage} />
            <Input type="text" value={product.name ? (product.name) : ('')} placeholder="Product name" onChange={e => setProduct({ ...product, name: e.target.value })} messageBottom="Name of the service that will be visible to the user when choosing one for purchase." autoComplete="off" />
            <TextArea type="text" value={product.description ? (product.description) : ('')} placeholder="Description (Optional)" onChange={e => setProduct({ ...product, description: e.target.value })} />
            <Input type="number" value={product.price ? (product.price) : (0)} placeholder="Price" onChange={e => setProduct({ ...product, price: e.target.value })} step="any" />
            <Input type="number" value={product.quantityStore ? (product.quantityStore) : (0)} placeholder="Amount in stock" onChange={e => setProduct({ ...product, quantityStore: e.target.value })} step="any" />
            <Input type="text" value={product.weight ? (product.weight) : ('')} placeholder="Weight" onChange={e => setProduct({ ...product, weight: e.target.value })} messageBottom="Need to set the weight unit of the product. Ex 150g or 15kg" autoComplete="off" />
            <Input type="text" value={product.indicationPet ? (product.indicationPet) : ('')} placeholder="Indication" onChange={e => setProduct({ ...product, indicationPet: e.target.value })} messageBottom="For whom this product is indicated. Ex Dog, Cat..." autoComplete="off" />
            <Input type="text" value={product.porte ? (product.porte) : ('')} placeholder="Porte" onChange={e => setProduct({ ...product, postage: e.target.value })} messageBottom="What is the size of the animal. Ex Small, Medium or Large" autoComplete="off" />
            <Input type="text" value={product.age ? (product.age) : ('')} placeholder="Age" onChange={e => setProduct({ ...product, age: e.target.value })} messageBottom="Pup, Adult, Elderly... ." autoComplete="off" />
            <Input type="text" value={product.transgenic ? (product.transgenic) : ('')} placeholder="Transgenic" onChange={e => setProduct({ ...product, transgenic: e.target.value })} autoComplete="off" />
            <TextArea type="text" value={product.composition ? (product.composition) : ('')} placeholder="Composition." onChange={e => setProduct({ ...product, composition: e.target.value })} />
            <ButtonForm text="Confirm Change" />
          </form>
        </div>
      </div>
    </>
  );
}