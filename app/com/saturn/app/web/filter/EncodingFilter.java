package com.saturn.app.web.filter;

import javax.servlet.*;
import java.io.IOException;

/**
 * 设置请求字符集过滤器
 * 
 * @author 谷钰
 *
 */
public class EncodingFilter implements Filter {

    private static final String INIT_IGNORE = "ignore";

	private static final String INIT_ENCODING = "encoding";

	private static final String DEFAULT_CHARACTER_ENCODING = "UTF-8";

	/**
     * 默认的请求字符集为UTF-8
     */
    protected String encoding = DEFAULT_CHARACTER_ENCODING;

    /**
     * 是否忽略客户自定义的字符集, "true"时无论客户是否设置字符集都会根据<code>encoding</code>设置字符集
     */
    protected boolean ignore = true;


    public void destroy() {
        this.encoding = null;
    }

    /**
     * 通过配置的<code>encoding</code>参数和<code>ignore</code>来设置请求字符集
     *
     * @param request  The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain    The filter chain we are processing
     * @throws IOException      if an input/output error occurs
     * @throws ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (ignore || (request.getCharacterEncoding() == null)) {
            String encoding = selectEncoding(request);
            if (encoding != null) {
                request.setCharacterEncoding(encoding);
            }
        }

        chain.doFilter(request, response);
    }

    /**
     * 初始化字符集过滤器参数<p>
     * 
     * <li> encoding : 有效字符集名称 UTF-8, GB2312, GBK等
     * <li> ignore : 是否忽略客户端自定义设置的字符集 ture , fasle
     *
     * @param filterConfig 过滤器配置对象
     */
    public void init(FilterConfig filterConfig)
            throws ServletException {

        this.encoding = filterConfig.getInitParameter(INIT_ENCODING);
        String value = filterConfig.getInitParameter(INIT_IGNORE);
        if (value == null) {
            this.ignore = true;
        } else {
            if (value.equalsIgnoreCase("true")) {
                this.ignore = true;
            } else {
                if (value.equalsIgnoreCase("yes")) {
                    this.ignore = true;
                } else {
                    this.ignore = false;
                }
            }
        }
    }

    protected String selectEncoding(ServletRequest request) {
        return (this.encoding);
    }

}
