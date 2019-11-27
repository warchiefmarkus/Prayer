package org.qtproject.example.notification;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.support.v4.app.NotificationCompat;
import android.util.Log;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;
import android.widget.Button;
import android.content.BroadcastReceiver;
import android.os.Bundle;
import android.os.IBinder;
import android.app.Service;
import android.app.IntentService;
import android.os.Vibrator;


public class PrayerService extends IntentService {

    public static final String NOTIFICATION = "org.qtproject.example.notification";
    private static PrayerService m_instance;
    public static NotificationManager notificationManager;
    private static Vibrator m_vibrator;

    private static NotificationCompat.Builder m_builder;
    public static Notification notif;

    private static int icon;
    public static RemoteViews contentView;

    public static Intent intent;
    public static Bundle bundle;
    public static PendingIntent pending;

    public static Intent intentNew;
    public static Bundle bundleNew;
    public static PendingIntent pendingNew;

    public static Intent intentNewNew;
    public static Bundle bundleNewNew;
    public static PendingIntent pendingNewNew;


        public PrayerService() {
            super("PrayerService");
            m_instance = this;
           }

        @Override
        public IBinder onBind(Intent arg0){
            Log.d("TAG", "FirstService Binded");
            return null;
        }

        public static void update_notification(String text){
            contentView = new RemoteViews("org.qtproject.example.notification", R.layout.mylayout);

            m_builder = new NotificationCompat.Builder(m_instance);
            m_builder.setSmallIcon(R.drawable.icon);
            m_builder.setContentTitle("A message from Qt!");
            m_builder.setAutoCancel(false);

            notif = m_builder.build();

            contentView.setTextViewText(R.id.counttext, text);

            notif.contentView = contentView;

            intent = new Intent(m_instance, myButtonListener.class);
            bundle = new Bundle();
            bundle.putInt("userAnswer", 1);
            intent.putExtras(bundle);
            //pending = PendingIntent.getActivity(m_instance, 0, intent, 0); // Для нажатия на весь notification
            pending = PendingIntent.getBroadcast(m_instance, 1, intent, PendingIntent.FLAG_UPDATE_CURRENT); // Для нажатия на кнопку
            //notif.contentIntent = pending;
            contentView.setOnClickPendingIntent(R.id.mybutton, pending);

            intentNew = new Intent(m_instance, myButtonListener.class);
            bundleNew = new Bundle();
            bundleNew.putInt("userAnswer", 5);
            intentNew.putExtras(bundleNew);
            pendingNew = PendingIntent.getBroadcast(m_instance, 2, intentNew, PendingIntent.FLAG_UPDATE_CURRENT); // Для нажатия на кнопку
            contentView.setOnClickPendingIntent(R.id.mybutton2, pendingNew);

            intentNewNew = new Intent(m_instance, myButtonListener.class);
            bundleNewNew = new Bundle();
            bundleNewNew.putInt("userAnswer", 20);
            intentNewNew.putExtras(bundleNewNew);
            pendingNewNew = PendingIntent.getBroadcast(m_instance, 3, intentNewNew, PendingIntent.FLAG_UPDATE_CURRENT); // Для нажатия на кнопку
            contentView.setOnClickPendingIntent(R.id.mybutton3, pendingNewNew);
        }

        public static void show_update_notif(String str){
            m_vibrator.vibrate(80);
            update_notification(str);
            notificationManager = (NotificationManager)m_instance.getSystemService(m_instance.NOTIFICATION_SERVICE);
            notificationManager.notify(1, notif);
        }


        @Override
        public int onStartCommand(Intent intent, int flags, int startId) {
            Log.d("TAG", "FirstService onStartCommand !!!");
            m_vibrator = (Vibrator)getSystemService(m_instance.VIBRATOR_SERVICE);
            update_notification("");
            startForeground(1, notif);

            return START_NOT_STICKY;
        }

        @Override
        public void onDestroy(){
            super    .onDestroy();
            Log.d("TAG", "FirstService Destroyed");
        }

        @Override
        protected void onHandleIntent(Intent intent) {
            Log.d("TAG", "FirstService onHandle Event CALLED !!!");
        }

        public static class myButtonListener extends BroadcastReceiver{
            @Override
            public void onReceive(Context context, Intent intent){

                Bundle answerBundle = intent.getExtras();
                int userAnswer = answerBundle.getInt("userAnswer");
                if (userAnswer == 1){
                    Intent intentw = new Intent(NOTIFICATION);
                    intentw.putExtra("count", 1);
                    context.sendBroadcast(intentw);

                }else if (userAnswer == 5){
                    Intent intentw = new Intent(NOTIFICATION);
                    intentw.putExtra("count", 5);
                    context.sendBroadcast(intentw);

                }else if (userAnswer == 20){
                    Intent intentw = new Intent(NOTIFICATION);
                    intentw.putExtra("count", 20);
                    context.sendBroadcast(intentw);
                }
            }
        }
}
