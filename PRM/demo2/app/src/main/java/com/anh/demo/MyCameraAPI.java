package com.anh.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.hardware.Camera;
import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.Toast;

public class MyCameraAPI extends AppCompatActivity {
    private Camera cameraObject;
    private ShowCamera showCamera;
    private ImageView pic;
    public static Camera isCameraAvailable(){
        Camera object=null;
        try{
            object=Camera.open();
        }catch (Exception e){
            e.printStackTrace();
        }
        return object;
    }
    private android.hardware.Camera.PictureCallback capturedIt=new android.hardware.Camera.PictureCallback(){

        @Override
        public void onPictureTaken(byte[] data, android.hardware.Camera camera) {
            Bitmap bitmap= BitmapFactory.decodeByteArray(data,0,data.length);
            if(bitmap==null){
                Toast.makeText(getApplicationContext(),"Not taken", Toast.LENGTH_SHORT).show();

            }else{
                Toast.makeText(getApplicationContext(),"Taken", Toast.LENGTH_SHORT).show();
                pic.setImageBitmap(bitmap);
            }
            cameraObject.release();
        }
    };
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_camera_api);

        pic=findViewById(R.id.imgProcess);
        cameraObject=isCameraAvailable();
        showCamera=new ShowCamera(this,cameraObject);
        FrameLayout preview=findViewById(R.id.camera_preview);
        preview.addView(showCamera);
    }

    public void clickToSnap(View view) {
        cameraObject.takePicture(null,null,capturedIt);
    }
}