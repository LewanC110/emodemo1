package com.neuedu.interceptor;

import com.neuedu.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    /**
     *  核心控制器执行controller中方法之前执行
     *  如果此方法返回false，则控制器就不再执行controller中的方法了
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //免登录
        HttpSession httpSession = httpServletRequest.getSession();
        User user = (User) httpSession.getAttribute("user");
        if(user == null){
//            httpServletRequest.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(httpServletRequest,httpServletResponse);
            httpServletResponse.sendRedirect("/empdemo/user/loginView");
            return false;
        }
        return true;
    }

    /**
     *  此方法在controller中方法执行完成之后执行并且在视图渲染之前
     *  补救措施：
     *      少存值在这存
     *      多存在这清理
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    /**
     *  在controller方法执行完成之后并且在视图渲染之后
     *  清理工作和处理异常
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param e
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
