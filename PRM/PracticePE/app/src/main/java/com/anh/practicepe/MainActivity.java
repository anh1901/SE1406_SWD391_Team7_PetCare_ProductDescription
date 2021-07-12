package com.anh.practicepe;

import androidx.appcompat.app.AppCompatActivity;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    SQLiteDatabase db;
    EditText edt_name;
    EditText edt_class;
    TextView resultList;
    DBHelper helper;
    TextView tv_id;
    TextView tv_search;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        edt_name = findViewById(R.id.edt_name);
        edt_class = findViewById(R.id.edt_class);
        resultList = findViewById(R.id.tv_result_list);
        tv_id = findViewById(R.id.tv_id);
        tv_search = findViewById(R.id.tv_search);

    }

    public void addStudent(View view) {
        helper = new DBHelper(this, null);
        db = helper.getWritableDatabase();
        String insert = "INSERT INTO " + DBHelper.TABLE_NAME + " ("
                + DBHelper.NAME_COLUMN + ","
                + DBHelper.CLASS_COLUMN + ") VALUES (?,?)";
        db.execSQL(insert, new String[]{edt_name.getText().toString(), edt_class.getText().toString()});
        Toast.makeText(this,"Add successfully", Toast.LENGTH_SHORT).show();
        db.close();

    }

    public void listStudent(View view) {
        helper = new DBHelper(this, null);
        db = helper.getWritableDatabase();
        String sql = "SELECT * FROM " + DBHelper.TABLE_NAME;
        Cursor c = db.rawQuery(sql, null);
        String result = "";
        while (c.moveToNext()) {
            int id = c.getInt(c.getColumnIndex("id"));
            String name = c.getString(c.getColumnIndex("name"));
            String classRoom = c.getString(c.getColumnIndex("classRoom"));
            result += id+"-"+name + " (" + classRoom + ")\n";
        }
        resultList.setText(result);
        Toast.makeText(this,"Loading...", Toast.LENGTH_SHORT).show();
        db.close();
    }

    public void deleteStudent(View view) {
        helper = new DBHelper(this, null);
        db = helper.getWritableDatabase();

        int r = db.delete(DBHelper.TABLE_NAME, "ID = ?", new String[]{tv_id.getText().toString()+""});
        Toast.makeText(this,"Delete successfully...", Toast.LENGTH_SHORT).show();
        db.close();
    }

    public void searchStudent(View view) {
        helper = new DBHelper(this, null);
        db = helper.getWritableDatabase();

        String query = "SELECT * FROM " + DBHelper.TABLE_NAME + " WHERE " +
                DBHelper.ID_COLUMN + " = \"" + tv_search.getText().toString() + "\"";

        Cursor c = db.rawQuery(query, null);
        if (c.moveToFirst()) {
            int id = c.getInt(c.getColumnIndex("id"));
            String name = c.getString(c.getColumnIndex("name"));
            String classRoom = c.getString(c.getColumnIndex("classRoom"));
            tv_id.setText(id+"");
            edt_name.setText(name);
            edt_class.setText(classRoom);
        }
        db.close();
    }
}