// Copyright (C) 2012-2013 Vicente Botet
//
//  Distributed under the Boost Software License, Version 1.0. (See accompanying
//  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

#include <boost/config.hpp>
#if ! defined  BOOST_NO_CXX11_DECLTYPE
#define BOOST_RESULT_OF_USE_DECLTYPE
#endif


#define BOOST_THREAD_VERSION 4
//#define BOOST_THREAD_USES_LOG
#define BOOST_THREAD_USES_LOG_THREAD_ID

#include <boost/thread/detail/log.hpp>
#include <boost/thread/future.hpp>
#include <boost/assert.hpp>
#include <string>
#include <iostream>
#if defined BOOST_THREAD_PROVIDES_FUTURE_CONTINUATION

#ifdef BOOST_MSVC
#pragma warning(disable: 4127) // conditional expression is constant
#endif

int p1()
{
  BOOST_THREAD_LOG << "P1" << BOOST_THREAD_END_LOG;
  return 123;
}

int p2(boost::future<int> f)
{
  BOOST_THREAD_LOG << "P2<" << BOOST_THREAD_END_LOG;
  try
  {
    return 2 * f.get();
  }
  catch (std::exception& ex)
  {
    std::cout << "ERRORRRRR "<<ex.what() << "" << std::endl;
    BOOST_THREAD_LOG << "ERRORRRRR "<<ex.what() << "" << BOOST_THREAD_END_LOG;
    BOOST_ASSERT(false);
  }
  catch (...)
  {
    BOOST_THREAD_LOG << " ERRORRRRR exception thrown" << BOOST_THREAD_END_LOG;
    BOOST_ASSERT(false);
  }
  BOOST_THREAD_LOG << "P2>" << BOOST_THREAD_END_LOG;
  return 0;
}
int p2s(boost::shared_future<int> f)
{
  BOOST_THREAD_LOG << "<P2S" << BOOST_THREAD_END_LOG;
  try
  {
    return 2 * f.get();
  }
  catch (std::exception& ex)
  {
    std::cout << "ERRORRRRR "<<ex.what() << "" << std::endl;
    BOOST_THREAD_LOG << "ERRORRRRR "<<ex.what() << "" << BOOST_THREAD_END_LOG;
    BOOST_ASSERT(false);
  }
  catch (...)
  {
    BOOST_THREAD_LOG << " ERRORRRRR exception thrown" << BOOST_THREAD_END_LOG;
    BOOST_ASSERT(false);
  }
  BOOST_THREAD_LOG << "P2S>" << BOOST_THREAD_END_LOG;
  return 0;
}

int main()
{
  const int number_of_tests = 100;
  BOOST_THREAD_LOG << "<MAIN" << BOOST_THREAD_END_LOG;
  {
    for (int i=0; i< number_of_tests; i++)
    try
    {
      BOOST_THREAD_LOG << "" << BOOST_THREAD_END_LOG;
      boost::future<int> f1 = boost::async(&p1);
      BOOST_THREAD_LOG << "" << BOOST_THREAD_END_LOG;
      boost::future<int> f2 = f1.then(&p2);
      BOOST_THREAD_LOG << "" << BOOST_THREAD_END_LOG;
      (void)f2.get();
      BOOST_THREAD_LOG << "" << BOOST_THREAD_END_LOG;
    }
    catch (std::exception& ex)
    {
      std::cout << "ERRORRRRR "<<ex.what() << "" << std::endl;
      BOOST_THREAD_LOG << "ERRORRRRR "<<ex.what() << "" << BOOST_THREAD_END_LOG;
      return 1;
    }
    catch (...)
    {
      BOOST_THREAD_LOG << " ERRORRRRR exception thrown" << BOOST_THREAD_END_LOG;
      return 2;
    }
  }
  {
    for (int i=0; i< number_of_tests; i++)
    try
    {
      BOOST_THREAD_LOG << "" << BOOST_THREAD_END_LOG;
      boost::shared_future<int> f1 = boost::async(&p1).share();
      BOOST_THREAD_LOG << "" << BOOST_THREAD_END_LOG;
      boost::future<int> f2 = f1.then(&p2s);
      BOOST_THREAD_LOG << "" << BOOST_THREAD_END_LOG;
      (void)f2.get();
      BOOST_THREAD_LOG << "" << BOOST_THREAD_END_LOG;
    }
    catch (std::exception& ex)
    {
      std::cout << "ERRORRRRR "<<ex.what() << "" << std::endl;
      BOOST_THREAD_LOG << "ERRORRRRR "<<ex.what() << "" << BOOST_THREAD_END_LOG;
      return 1;
    }
    catch (...)
    {
      BOOST_THREAD_LOG << " ERRORRRRR exception thrown" << BOOST_THREAD_END_LOG;
      return 2;
    }
  }
  BOOST_THREAD_LOG << "MAIN>" << BOOST_THREAD_END_LOG;
  return 0;
}
#else

int main()
{
  return 0;
}
#endif


// #include <boost/locale.hpp>
// #include <iostream>
// #include <iomanip>
// #include <ctime>
// 
// int main()
// {
// 
//     using namespace boost::locale;
// 
//     generator gen;
//     std::locale::global(gen(""));
//     std::cout.imbue(std::locale());
//     // Setup environment
// 
//     boost::locale::date_time now;
// 
//     date_time start=now;
// 
//     // Set the first day of the first month of this year
//     start.set(period::month(),now.minimum(period::month()));
//     start.set(period::day(),start.minimum(period::day()));
// 
// 
//     int current_year = period::year(now);
// 
// 
//     // Display current year
//     std::cout << format("{1,ftime='%Y'}") % now << std::endl;
// 
//     //
//     // Run forward untill current year is the date
//     //
//     for(now=start; period::year(now) == current_year;) {
// 
// 
//         // Print heading of month
//         if(calendar().is_gregorian()) 
//             std::cout << format("{1,ftime='%B'}") % now <<std::endl;
//         else
//             std::cout << format("{1,ftime='%B'} ({1,ftime='%Y-%m-%d',locale=en} - {2,locale=en,ftime='%Y-%m-%d'})")
//                 % now 
//                 % date_time(now,now.maximum(period::day())*period::day()) << std::endl;
// 
//         int first = calendar().first_day_of_week();
// 
//         // Print weeks days
//         for(int i=0;i<7;i++) {
//             date_time tmp(now,period::day_of_week() * (first + i));
//             std::cout << format("{1,w=8,ftime='%a'} ") % tmp;
//         }
// 
//         std::cout << std::endl;
// 
// 
//         int current_month = now / period::month();
//         int skip = now / period::day_of_week_local() - 1;
// 
//         for(int i=0;i<skip*9;i++)
//             std::cout << ' ';
//         for(;now / period::month() == current_month ;now += period::day()) {
//             std::cout << format("{1,w=8,ftime='%e'} ") % now;     
//             if(now / period::day_of_week_local() == 7)
//                 std::cout << std::endl;
//         }
//         std::cout << std::endl;
//     }
// }
