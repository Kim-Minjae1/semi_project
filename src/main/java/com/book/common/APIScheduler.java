package com.book.common;

import static org.quartz.CronScheduleBuilder.cronSchedule;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServlet;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.impl.StdSchedulerFactory;
import com.book.admin.event.controller.GetEventRegular;

public class APIScheduler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private SchedulerFactory schedulerFactory;
	private Scheduler scheduler;
	
	public APIScheduler() {
		try {
			schedulerFactory = new StdSchedulerFactory();
			scheduler = schedulerFactory.getScheduler();
		}
		catch (SchedulerException e) {
				e.printStackTrace();
		}
	}
	
	@Override
	public void init() {
		try {
			JobDetail job = newJob(GetEventRegular.class)
							.withIdentity("job1", "group1")
							.build();
			
			CronTrigger trigger = newTrigger()
							.withIdentity("trigger1", "group1")
							.withSchedule(cronSchedule("0/30 * * * * ?")) // 30초마다 
							.build();
			scheduler.scheduleJob(job, trigger);
			
			scheduler.start();
			// scheduler.shutdown(true);
		}
		catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
		 
}
