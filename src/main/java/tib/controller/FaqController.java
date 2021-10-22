package tib.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import tib.faq.model.FaqDAO;
import tib.services.model.ServicesDAO;

@Controller
public class FaqController {

   @Autowired
   private FaqDAO faqDao;
   
   @Autowired
   private ServicesDAO servicesDao;

   /**
    * #faqForm
    * */
   @RequestMapping("/index2.do")
   public ModelAndView faqForm() {
    
      ModelAndView mav = new ModelAndView();
      
      List slist = servicesDao.servicesAllList();
      
      mav.addObject("slists", slist);
       mav.setViewName("index2");

       return mav;
   }

   
}