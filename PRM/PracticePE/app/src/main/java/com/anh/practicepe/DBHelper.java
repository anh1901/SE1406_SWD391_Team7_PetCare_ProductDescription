package com.anh.practicepe;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

public class DBHelper extends SQLiteOpenHelper {
    public static String DATABASE_NAME = "studentDB";
    public static String TABLE_NAME = "student";
    public static String ID_COLUMN = "id";
    public static String NAME_COLUMN = "name";
    public static String CLASS_COLUMN = "classRoom";

    String CREATE_TABLE = "CREATE TABLE "+ TABLE_NAME+ "("
            + ID_COLUMN +" INTEGER PRIMARY KEY, " +
            NAME_COLUMN + "TEXT NOT NULL, " + CLASS_COLUMN +"TEXT NOT NULL)";
    public static int VERSION = 1;

    public DBHelper(@Nullable Context context,
                       @Nullable SQLiteDatabase.CursorFactory factory) {
        super(context, DATABASE_NAME, factory, VERSION);
    }
    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_STUDENTS_TABLE = "CREATE TABLE " +
                TABLE_NAME + "("
                + ID_COLUMN + " INTEGER PRIMARY KEY," +
                NAME_COLUMN
                + " TEXT," + CLASS_COLUMN + " TEXT" + ")";
        db.execSQL(CREATE_STUDENTS_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        if (newVersion > oldVersion) {
            String DROP_TABLE = "DROP TABLE if EXISTS "+TABLE_NAME;
            db.execSQL(DROP_TABLE);
            db.execSQL(CREATE_TABLE);
        }
    }
}
