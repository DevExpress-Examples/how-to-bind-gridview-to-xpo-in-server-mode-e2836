﻿using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using DevExpress.Xpo.Metadata;
using E2836.Models;
using System;

namespace E2836.Helpers
{
    /// <summary>
    /// Summary description for XpoHelper
    /// </summary>
    public static class XpoHelper
    {
        static XpoHelper()
        {
            CreateDefaultObjects();
        }

        public static Session GetNewSession()
        {
            return new Session(DataLayer);
        }

        public static UnitOfWork GetNewUnitOfWork()
        {
            return new UnitOfWork(DataLayer);
        }

        private readonly static object lockObject = new object();

        static IDataLayer fDataLayer;
        static IDataLayer DataLayer
        {
            get
            {
                if (fDataLayer == null)
                {
                    lock (lockObject)
                    {
                        fDataLayer = GetDataLayer();
                    }
                }
                return fDataLayer;
            }
        }

        private static IDataLayer GetDataLayer()
        {
            XpoDefault.Session = null;

            InMemoryDataStore ds = new InMemoryDataStore();

            XPDictionary dict = new ReflectionDictionary();
            dict.GetDataStoreSchema(typeof(MyObject).Assembly);

            return new ThreadSafeDataLayer(dict, ds);
        }

        static void CreateDefaultObjects()
        {
            using (UnitOfWork uow = GetNewUnitOfWork())
            {
                MyObject obj = null;

                for (Int32 i = 0; i < 1234; i++)
                {
                    obj = new MyObject(uow);
                    obj.Title = "Item " + i.ToString();
                }

                uow.CommitChanges();
            }
        }
    }
}