package org.qtproject.example.notification;

import android.content.Context;
import android.util.Log;
import android.content.Context;
import android.content.Intent;
import android.content.BroadcastReceiver;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.IBinder;
import android.app.Service;


public class NotificationClient extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static NotificationClient m_instance;

    private static native void callNativeCount(int x);
    private static native void callNativeOptions(int x);

    private BroadcastReceiver receiver = new BroadcastReceiver() {
      @Override

      public void onReceive(Context context, Intent intent) {
Log.d("MY"," notif get recev ");
        Bundle bundle = intent.getExtras();
        if (bundle != null) {
            Log.d("MY"," bundle not null ");
               int string = bundle.getInt("count");
               if (string == 1) {
                   callNativeCount(1);
                   Log.d("MY"," try call native ");
               }
               else if (string == 5){
                   callNativeCount(5);
               }
               else if (string == 20){
                   callNativeCount(20);
               }
           }
       }
    };

    @Override
    protected void onResume() {
      super.onResume();
      registerReceiver(receiver, new IntentFilter(PrayerService.NOTIFICATION));
    }

    @Override
    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        startService(new Intent(m_instance, PrayerService.class));
    }

    public NotificationClient()
    {
        m_instance = this;        
        //contentView.setImageViewResource(R.id.image, R.drawable.icon);
    }

    public static void notify(String s)
    {

    }
}




