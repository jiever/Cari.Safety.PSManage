using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Cari.Safety.DTO.PSManage;

namespace Cari.Safety.BLL.PSManage
{
    public static class RequestToApi
    {
        public static ApiResponseDto Get(string url)
        {
            if (!url.StartsWith("http"))
            {
                url = "http://" + url;
            }
            HttpClient myHttpClient = new HttpClient();
            HttpResponseMessage response = myHttpClient.GetAsync(url).Result;
            string result = "";
            var statusCode = response.StatusCode.ToString();
            if (response.IsSuccessStatusCode)
            {
                result = response.Content.ReadAsStringAsync().Result;
            }

            return new ApiResponseDto(){StatusCode = statusCode, Content = result};
        }

        public static ApiResponseDto Post(string url, string postData)
        {
            string result = "";
            if (!url.StartsWith("http"))
            {
                url = "http://" + url;
            }
            HttpClient myHttpClient = new HttpClient();
            HttpContent httpContent = new StringContent(postData);
            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            httpContent.Headers.ContentType.CharSet = "utf-8";

            HttpResponseMessage response = myHttpClient.PostAsync(url, httpContent).Result;

            var statusCode = response.StatusCode.ToString();
            if (response.IsSuccessStatusCode)
            {
                result = response.Content.ReadAsStringAsync().Result;
            }

            return new ApiResponseDto(){ StatusCode = statusCode, Content = result };
        }
    }
}
