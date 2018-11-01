using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Cari.Safety.BLL.PSManage
{
    public static class RequestToApi
    {
        public static string Get(string url,out string statusCode)
        {
            if (!url.StartsWith("http"))
            {
                url = "http://" + url;
            }
            HttpClient myHttpClient = new HttpClient();
            HttpResponseMessage response = myHttpClient.GetAsync(url).Result;
            string result = "";
            statusCode = response.StatusCode.ToString();
            if (response.IsSuccessStatusCode)
            {
                result = response.Content.ReadAsStringAsync().Result;
            }

            return result;
        }

        public static string Post(string url, string postData, out string statusCode)
        {
            string result = "";
            if (!url.StartsWith("http"))
            {
                url = "http://" + url;
            }
            HttpClient myHttpClient = new HttpClient();
            HttpContent httpContent = new StringContent(postData);
            HttpResponseMessage response = myHttpClient.PostAsync(url, httpContent).Result;

            statusCode = response.StatusCode.ToString();
            if (response.IsSuccessStatusCode)
            {
                return result = response.Content.ReadAsStringAsync().Result;
            }

            return result;
        }
    }
}
