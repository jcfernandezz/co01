
/*
'===============================================================================
'  Generated From - CSharp_dOOdads_BusinessEntity.vbgen
' 
'  ** IMPORTANT  ** 
'  How to Generate your stored procedures:
' 
'  SQL        = SQL_StoredProcs.vbgen
'  ACCESS     = Access_StoredProcs.vbgen
'  ORACLE     = Oracle_StoredProcs.vbgen
'  FIREBIRD   = FirebirdStoredProcs.vbgen
'  POSTGRESQL = PostgreSQL_StoredProcs.vbgen
'
'  The supporting base class SqlClientEntity is in the Architecture directory in "dOOdads".
'  
'  This object is 'abstract' which means you need to inherit from it to be able
'  to instantiate it.  This is very easilly done. You can override properties and
'  methods in your derived class, this allows you to regenerate this class at any
'  time and not worry about overwriting custom code. 
'
'  NEVER EDIT THIS FILE.
'
'  public class YourObject :  _YourObject
'  {
'
'  }
'
'===============================================================================
*/

// Generated by MyGeneration Version # (1.3.0.3)

using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Specialized;

using MyGeneration.dOOdads;

namespace MVP.gpCustom
{
	public abstract class _GL00105 : SqlClientEntity
	{
		public _GL00105()
		{
			this.QuerySource = "GL00105";
			this.MappingName = "GL00105";

		}	

		//=================================================================
		//  public Overrides void AddNew()
		//=================================================================
		//
		//=================================================================
		public override void AddNew()
		{
			base.AddNew();
			
		}
		
		
		public override void FlushData()
		{
			this._whereClause = null;
			this._aggregateClause = null;
			base.FlushData();
		}
		
		//=================================================================
		//  	public Function LoadAll() As Boolean
		//=================================================================
		//  Loads all of the records in the database, and sets the currentRow to the first row
		//=================================================================
		public bool LoadAll() 
		{
			ListDictionary parameters = null;
			
			return base.LoadFromSql("[" + this.SchemaStoredProcedure + "proc_GL00105LoadAll]", parameters);
		}
	
		//=================================================================
		// public Overridable Function LoadByPrimaryKey()  As Boolean
		//=================================================================
		//  Loads a single row of via the primary key
		//=================================================================
		public virtual bool LoadByPrimaryKey(int ACTINDX)
		{
			ListDictionary parameters = new ListDictionary();
			parameters.Add(Parameters.ACTINDX, ACTINDX);

		
			return base.LoadFromSql("[" + this.SchemaStoredProcedure + "proc_GL00105LoadByPrimaryKey]", parameters);
		}
		
		#region Parameters
		protected class Parameters
		{
			
			public static SqlParameter ACTINDX
			{
				get
				{
					return new SqlParameter("@ACTINDX", SqlDbType.Int, 0);
				}
			}
			
			public static SqlParameter ACTNUMBR_1
			{
				get
				{
					return new SqlParameter("@ACTNUMBR_1", SqlDbType.Char, 9);
				}
			}
			
			public static SqlParameter ACTNUMBR_2
			{
				get
				{
					return new SqlParameter("@ACTNUMBR_2", SqlDbType.Char, 9);
				}
			}
			
			public static SqlParameter ACTNUMBR_3
			{
				get
				{
					return new SqlParameter("@ACTNUMBR_3", SqlDbType.Char, 9);
				}
			}
			
			public static SqlParameter ACTNUMBR_4
			{
				get
				{
					return new SqlParameter("@ACTNUMBR_4", SqlDbType.Char, 9);
				}
			}
			
			public static SqlParameter ACTNUMBR_5
			{
				get
				{
					return new SqlParameter("@ACTNUMBR_5", SqlDbType.Char, 9);
				}
			}
			
			public static SqlParameter ACTNUMBR_6
			{
				get
				{
					return new SqlParameter("@ACTNUMBR_6", SqlDbType.Char, 9);
				}
			}
			
			public static SqlParameter ACTNUMST
			{
				get
				{
					return new SqlParameter("@ACTNUMST", SqlDbType.Char, 129);
				}
			}
			
			public static SqlParameter DEX_ROW_ID
			{
				get
				{
					return new SqlParameter("@DEX_ROW_ID", SqlDbType.Int, 0);
				}
			}
			
		}
		#endregion		
	
		#region ColumnNames
		public class ColumnNames
		{  
            public const string ACTINDX = "ACTINDX";
            public const string ACTNUMBR_1 = "ACTNUMBR_1";
            public const string ACTNUMBR_2 = "ACTNUMBR_2";
            public const string ACTNUMBR_3 = "ACTNUMBR_3";
            public const string ACTNUMBR_4 = "ACTNUMBR_4";
            public const string ACTNUMBR_5 = "ACTNUMBR_5";
            public const string ACTNUMBR_6 = "ACTNUMBR_6";
            public const string ACTNUMST = "ACTNUMST";
            public const string DEX_ROW_ID = "DEX_ROW_ID";

			static public string ToPropertyName(string columnName)
			{
				if(ht == null)
				{
					ht = new Hashtable();
					
					ht[ACTINDX] = _GL00105.PropertyNames.ACTINDX;
					ht[ACTNUMBR_1] = _GL00105.PropertyNames.ACTNUMBR_1;
					ht[ACTNUMBR_2] = _GL00105.PropertyNames.ACTNUMBR_2;
					ht[ACTNUMBR_3] = _GL00105.PropertyNames.ACTNUMBR_3;
					ht[ACTNUMBR_4] = _GL00105.PropertyNames.ACTNUMBR_4;
					ht[ACTNUMBR_5] = _GL00105.PropertyNames.ACTNUMBR_5;
					ht[ACTNUMBR_6] = _GL00105.PropertyNames.ACTNUMBR_6;
					ht[ACTNUMST] = _GL00105.PropertyNames.ACTNUMST;
					ht[DEX_ROW_ID] = _GL00105.PropertyNames.DEX_ROW_ID;

				}
				return (string)ht[columnName];
			}

			static private Hashtable ht = null;			 
		}
		#endregion
		
		#region PropertyNames
		public class PropertyNames
		{  
            public const string ACTINDX = "ACTINDX";
            public const string ACTNUMBR_1 = "ACTNUMBR_1";
            public const string ACTNUMBR_2 = "ACTNUMBR_2";
            public const string ACTNUMBR_3 = "ACTNUMBR_3";
            public const string ACTNUMBR_4 = "ACTNUMBR_4";
            public const string ACTNUMBR_5 = "ACTNUMBR_5";
            public const string ACTNUMBR_6 = "ACTNUMBR_6";
            public const string ACTNUMST = "ACTNUMST";
            public const string DEX_ROW_ID = "DEX_ROW_ID";

			static public string ToColumnName(string propertyName)
			{
				if(ht == null)
				{
					ht = new Hashtable();
					
					ht[ACTINDX] = _GL00105.ColumnNames.ACTINDX;
					ht[ACTNUMBR_1] = _GL00105.ColumnNames.ACTNUMBR_1;
					ht[ACTNUMBR_2] = _GL00105.ColumnNames.ACTNUMBR_2;
					ht[ACTNUMBR_3] = _GL00105.ColumnNames.ACTNUMBR_3;
					ht[ACTNUMBR_4] = _GL00105.ColumnNames.ACTNUMBR_4;
					ht[ACTNUMBR_5] = _GL00105.ColumnNames.ACTNUMBR_5;
					ht[ACTNUMBR_6] = _GL00105.ColumnNames.ACTNUMBR_6;
					ht[ACTNUMST] = _GL00105.ColumnNames.ACTNUMST;
					ht[DEX_ROW_ID] = _GL00105.ColumnNames.DEX_ROW_ID;

				}
				return (string)ht[propertyName];
			}

			static private Hashtable ht = null;			 
		}			 
		#endregion	

		#region StringPropertyNames
		public class StringPropertyNames
		{  
            public const string ACTINDX = "s_ACTINDX";
            public const string ACTNUMBR_1 = "s_ACTNUMBR_1";
            public const string ACTNUMBR_2 = "s_ACTNUMBR_2";
            public const string ACTNUMBR_3 = "s_ACTNUMBR_3";
            public const string ACTNUMBR_4 = "s_ACTNUMBR_4";
            public const string ACTNUMBR_5 = "s_ACTNUMBR_5";
            public const string ACTNUMBR_6 = "s_ACTNUMBR_6";
            public const string ACTNUMST = "s_ACTNUMST";
            public const string DEX_ROW_ID = "s_DEX_ROW_ID";

		}
		#endregion		
		
		#region Properties
	
		public virtual int ACTINDX
	    {
			get
	        {
				return base.Getint(ColumnNames.ACTINDX);
			}
			set
	        {
				base.Setint(ColumnNames.ACTINDX, value);
			}
		}

		public virtual string ACTNUMBR_1
	    {
			get
	        {
				return base.Getstring(ColumnNames.ACTNUMBR_1);
			}
			set
	        {
				base.Setstring(ColumnNames.ACTNUMBR_1, value);
			}
		}

		public virtual string ACTNUMBR_2
	    {
			get
	        {
				return base.Getstring(ColumnNames.ACTNUMBR_2);
			}
			set
	        {
				base.Setstring(ColumnNames.ACTNUMBR_2, value);
			}
		}

		public virtual string ACTNUMBR_3
	    {
			get
	        {
				return base.Getstring(ColumnNames.ACTNUMBR_3);
			}
			set
	        {
				base.Setstring(ColumnNames.ACTNUMBR_3, value);
			}
		}

		public virtual string ACTNUMBR_4
	    {
			get
	        {
				return base.Getstring(ColumnNames.ACTNUMBR_4);
			}
			set
	        {
				base.Setstring(ColumnNames.ACTNUMBR_4, value);
			}
		}

		public virtual string ACTNUMBR_5
	    {
			get
	        {
				return base.Getstring(ColumnNames.ACTNUMBR_5);
			}
			set
	        {
				base.Setstring(ColumnNames.ACTNUMBR_5, value);
			}
		}

		public virtual string ACTNUMBR_6
	    {
			get
	        {
				return base.Getstring(ColumnNames.ACTNUMBR_6);
			}
			set
	        {
				base.Setstring(ColumnNames.ACTNUMBR_6, value);
			}
		}

		public virtual string ACTNUMST
	    {
			get
	        {
				return base.Getstring(ColumnNames.ACTNUMST);
			}
			set
	        {
				base.Setstring(ColumnNames.ACTNUMST, value);
			}
		}

		public virtual int DEX_ROW_ID
	    {
			get
	        {
				return base.Getint(ColumnNames.DEX_ROW_ID);
			}
			set
	        {
				base.Setint(ColumnNames.DEX_ROW_ID, value);
			}
		}


		#endregion
		
		#region String Properties
	
		public virtual string s_ACTINDX
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.ACTINDX) ? string.Empty : base.GetintAsString(ColumnNames.ACTINDX);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.ACTINDX);
				else
					this.ACTINDX = base.SetintAsString(ColumnNames.ACTINDX, value);
			}
		}

		public virtual string s_ACTNUMBR_1
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.ACTNUMBR_1) ? string.Empty : base.GetstringAsString(ColumnNames.ACTNUMBR_1);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.ACTNUMBR_1);
				else
					this.ACTNUMBR_1 = base.SetstringAsString(ColumnNames.ACTNUMBR_1, value);
			}
		}

		public virtual string s_ACTNUMBR_2
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.ACTNUMBR_2) ? string.Empty : base.GetstringAsString(ColumnNames.ACTNUMBR_2);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.ACTNUMBR_2);
				else
					this.ACTNUMBR_2 = base.SetstringAsString(ColumnNames.ACTNUMBR_2, value);
			}
		}

		public virtual string s_ACTNUMBR_3
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.ACTNUMBR_3) ? string.Empty : base.GetstringAsString(ColumnNames.ACTNUMBR_3);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.ACTNUMBR_3);
				else
					this.ACTNUMBR_3 = base.SetstringAsString(ColumnNames.ACTNUMBR_3, value);
			}
		}

		public virtual string s_ACTNUMBR_4
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.ACTNUMBR_4) ? string.Empty : base.GetstringAsString(ColumnNames.ACTNUMBR_4);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.ACTNUMBR_4);
				else
					this.ACTNUMBR_4 = base.SetstringAsString(ColumnNames.ACTNUMBR_4, value);
			}
		}

		public virtual string s_ACTNUMBR_5
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.ACTNUMBR_5) ? string.Empty : base.GetstringAsString(ColumnNames.ACTNUMBR_5);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.ACTNUMBR_5);
				else
					this.ACTNUMBR_5 = base.SetstringAsString(ColumnNames.ACTNUMBR_5, value);
			}
		}

		public virtual string s_ACTNUMBR_6
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.ACTNUMBR_6) ? string.Empty : base.GetstringAsString(ColumnNames.ACTNUMBR_6);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.ACTNUMBR_6);
				else
					this.ACTNUMBR_6 = base.SetstringAsString(ColumnNames.ACTNUMBR_6, value);
			}
		}

		public virtual string s_ACTNUMST
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.ACTNUMST) ? string.Empty : base.GetstringAsString(ColumnNames.ACTNUMST);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.ACTNUMST);
				else
					this.ACTNUMST = base.SetstringAsString(ColumnNames.ACTNUMST, value);
			}
		}

		public virtual string s_DEX_ROW_ID
	    {
			get
	        {
				return this.IsColumnNull(ColumnNames.DEX_ROW_ID) ? string.Empty : base.GetintAsString(ColumnNames.DEX_ROW_ID);
			}
			set
	        {
				if(string.Empty == value)
					this.SetColumnNull(ColumnNames.DEX_ROW_ID);
				else
					this.DEX_ROW_ID = base.SetintAsString(ColumnNames.DEX_ROW_ID, value);
			}
		}


		#endregion		
	
		#region Where Clause
		public class WhereClause
		{
			public WhereClause(BusinessEntity entity)
			{
				this._entity = entity;
			}
			
			public TearOffWhereParameter TearOff
			{
				get
				{
					if(_tearOff == null)
					{
						_tearOff = new TearOffWhereParameter(this);
					}

					return _tearOff;
				}
			}

			#region WhereParameter TearOff's
			public class TearOffWhereParameter
			{
				public TearOffWhereParameter(WhereClause clause)
				{
					this._clause = clause;
				}
				
				
				public WhereParameter ACTINDX
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.ACTINDX, Parameters.ACTINDX);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}

				public WhereParameter ACTNUMBR_1
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.ACTNUMBR_1, Parameters.ACTNUMBR_1);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}

				public WhereParameter ACTNUMBR_2
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.ACTNUMBR_2, Parameters.ACTNUMBR_2);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}

				public WhereParameter ACTNUMBR_3
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.ACTNUMBR_3, Parameters.ACTNUMBR_3);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}

				public WhereParameter ACTNUMBR_4
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.ACTNUMBR_4, Parameters.ACTNUMBR_4);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}

				public WhereParameter ACTNUMBR_5
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.ACTNUMBR_5, Parameters.ACTNUMBR_5);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}

				public WhereParameter ACTNUMBR_6
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.ACTNUMBR_6, Parameters.ACTNUMBR_6);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}

				public WhereParameter ACTNUMST
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.ACTNUMST, Parameters.ACTNUMST);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}

				public WhereParameter DEX_ROW_ID
				{
					get
					{
							WhereParameter where = new WhereParameter(ColumnNames.DEX_ROW_ID, Parameters.DEX_ROW_ID);
							this._clause._entity.Query.AddWhereParameter(where);
							return where;
					}
				}


				private WhereClause _clause;
			}
			#endregion
		
			public WhereParameter ACTINDX
		    {
				get
		        {
					if(_ACTINDX_W == null)
	        	    {
						_ACTINDX_W = TearOff.ACTINDX;
					}
					return _ACTINDX_W;
				}
			}

			public WhereParameter ACTNUMBR_1
		    {
				get
		        {
					if(_ACTNUMBR_1_W == null)
	        	    {
						_ACTNUMBR_1_W = TearOff.ACTNUMBR_1;
					}
					return _ACTNUMBR_1_W;
				}
			}

			public WhereParameter ACTNUMBR_2
		    {
				get
		        {
					if(_ACTNUMBR_2_W == null)
	        	    {
						_ACTNUMBR_2_W = TearOff.ACTNUMBR_2;
					}
					return _ACTNUMBR_2_W;
				}
			}

			public WhereParameter ACTNUMBR_3
		    {
				get
		        {
					if(_ACTNUMBR_3_W == null)
	        	    {
						_ACTNUMBR_3_W = TearOff.ACTNUMBR_3;
					}
					return _ACTNUMBR_3_W;
				}
			}

			public WhereParameter ACTNUMBR_4
		    {
				get
		        {
					if(_ACTNUMBR_4_W == null)
	        	    {
						_ACTNUMBR_4_W = TearOff.ACTNUMBR_4;
					}
					return _ACTNUMBR_4_W;
				}
			}

			public WhereParameter ACTNUMBR_5
		    {
				get
		        {
					if(_ACTNUMBR_5_W == null)
	        	    {
						_ACTNUMBR_5_W = TearOff.ACTNUMBR_5;
					}
					return _ACTNUMBR_5_W;
				}
			}

			public WhereParameter ACTNUMBR_6
		    {
				get
		        {
					if(_ACTNUMBR_6_W == null)
	        	    {
						_ACTNUMBR_6_W = TearOff.ACTNUMBR_6;
					}
					return _ACTNUMBR_6_W;
				}
			}

			public WhereParameter ACTNUMST
		    {
				get
		        {
					if(_ACTNUMST_W == null)
	        	    {
						_ACTNUMST_W = TearOff.ACTNUMST;
					}
					return _ACTNUMST_W;
				}
			}

			public WhereParameter DEX_ROW_ID
		    {
				get
		        {
					if(_DEX_ROW_ID_W == null)
	        	    {
						_DEX_ROW_ID_W = TearOff.DEX_ROW_ID;
					}
					return _DEX_ROW_ID_W;
				}
			}

			private WhereParameter _ACTINDX_W = null;
			private WhereParameter _ACTNUMBR_1_W = null;
			private WhereParameter _ACTNUMBR_2_W = null;
			private WhereParameter _ACTNUMBR_3_W = null;
			private WhereParameter _ACTNUMBR_4_W = null;
			private WhereParameter _ACTNUMBR_5_W = null;
			private WhereParameter _ACTNUMBR_6_W = null;
			private WhereParameter _ACTNUMST_W = null;
			private WhereParameter _DEX_ROW_ID_W = null;

			public void WhereClauseReset()
			{
				_ACTINDX_W = null;
				_ACTNUMBR_1_W = null;
				_ACTNUMBR_2_W = null;
				_ACTNUMBR_3_W = null;
				_ACTNUMBR_4_W = null;
				_ACTNUMBR_5_W = null;
				_ACTNUMBR_6_W = null;
				_ACTNUMST_W = null;
				_DEX_ROW_ID_W = null;

				this._entity.Query.FlushWhereParameters();

			}
	
			private BusinessEntity _entity;
			private TearOffWhereParameter _tearOff;
			
		}
	
		public WhereClause Where
		{
			get
			{
				if(_whereClause == null)
				{
					_whereClause = new WhereClause(this);
				}
		
				return _whereClause;
			}
		}
		
		private WhereClause _whereClause = null;	
		#endregion
	
		#region Aggregate Clause
		public class AggregateClause
		{
			public AggregateClause(BusinessEntity entity)
			{
				this._entity = entity;
			}
			
			public TearOffAggregateParameter TearOff
			{
				get
				{
					if(_tearOff == null)
					{
						_tearOff = new TearOffAggregateParameter(this);
					}

					return _tearOff;
				}
			}

			#region AggregateParameter TearOff's
			public class TearOffAggregateParameter
			{
				public TearOffAggregateParameter(AggregateClause clause)
				{
					this._clause = clause;
				}
				
				
				public AggregateParameter ACTINDX
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.ACTINDX, Parameters.ACTINDX);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}

				public AggregateParameter ACTNUMBR_1
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.ACTNUMBR_1, Parameters.ACTNUMBR_1);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}

				public AggregateParameter ACTNUMBR_2
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.ACTNUMBR_2, Parameters.ACTNUMBR_2);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}

				public AggregateParameter ACTNUMBR_3
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.ACTNUMBR_3, Parameters.ACTNUMBR_3);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}

				public AggregateParameter ACTNUMBR_4
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.ACTNUMBR_4, Parameters.ACTNUMBR_4);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}

				public AggregateParameter ACTNUMBR_5
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.ACTNUMBR_5, Parameters.ACTNUMBR_5);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}

				public AggregateParameter ACTNUMBR_6
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.ACTNUMBR_6, Parameters.ACTNUMBR_6);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}

				public AggregateParameter ACTNUMST
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.ACTNUMST, Parameters.ACTNUMST);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}

				public AggregateParameter DEX_ROW_ID
				{
					get
					{
							AggregateParameter aggregate = new AggregateParameter(ColumnNames.DEX_ROW_ID, Parameters.DEX_ROW_ID);
							this._clause._entity.Query.AddAggregateParameter(aggregate);
							return aggregate;
					}
				}


				private AggregateClause _clause;
			}
			#endregion
		
			public AggregateParameter ACTINDX
		    {
				get
		        {
					if(_ACTINDX_W == null)
	        	    {
						_ACTINDX_W = TearOff.ACTINDX;
					}
					return _ACTINDX_W;
				}
			}

			public AggregateParameter ACTNUMBR_1
		    {
				get
		        {
					if(_ACTNUMBR_1_W == null)
	        	    {
						_ACTNUMBR_1_W = TearOff.ACTNUMBR_1;
					}
					return _ACTNUMBR_1_W;
				}
			}

			public AggregateParameter ACTNUMBR_2
		    {
				get
		        {
					if(_ACTNUMBR_2_W == null)
	        	    {
						_ACTNUMBR_2_W = TearOff.ACTNUMBR_2;
					}
					return _ACTNUMBR_2_W;
				}
			}

			public AggregateParameter ACTNUMBR_3
		    {
				get
		        {
					if(_ACTNUMBR_3_W == null)
	        	    {
						_ACTNUMBR_3_W = TearOff.ACTNUMBR_3;
					}
					return _ACTNUMBR_3_W;
				}
			}

			public AggregateParameter ACTNUMBR_4
		    {
				get
		        {
					if(_ACTNUMBR_4_W == null)
	        	    {
						_ACTNUMBR_4_W = TearOff.ACTNUMBR_4;
					}
					return _ACTNUMBR_4_W;
				}
			}

			public AggregateParameter ACTNUMBR_5
		    {
				get
		        {
					if(_ACTNUMBR_5_W == null)
	        	    {
						_ACTNUMBR_5_W = TearOff.ACTNUMBR_5;
					}
					return _ACTNUMBR_5_W;
				}
			}

			public AggregateParameter ACTNUMBR_6
		    {
				get
		        {
					if(_ACTNUMBR_6_W == null)
	        	    {
						_ACTNUMBR_6_W = TearOff.ACTNUMBR_6;
					}
					return _ACTNUMBR_6_W;
				}
			}

			public AggregateParameter ACTNUMST
		    {
				get
		        {
					if(_ACTNUMST_W == null)
	        	    {
						_ACTNUMST_W = TearOff.ACTNUMST;
					}
					return _ACTNUMST_W;
				}
			}

			public AggregateParameter DEX_ROW_ID
		    {
				get
		        {
					if(_DEX_ROW_ID_W == null)
	        	    {
						_DEX_ROW_ID_W = TearOff.DEX_ROW_ID;
					}
					return _DEX_ROW_ID_W;
				}
			}

			private AggregateParameter _ACTINDX_W = null;
			private AggregateParameter _ACTNUMBR_1_W = null;
			private AggregateParameter _ACTNUMBR_2_W = null;
			private AggregateParameter _ACTNUMBR_3_W = null;
			private AggregateParameter _ACTNUMBR_4_W = null;
			private AggregateParameter _ACTNUMBR_5_W = null;
			private AggregateParameter _ACTNUMBR_6_W = null;
			private AggregateParameter _ACTNUMST_W = null;
			private AggregateParameter _DEX_ROW_ID_W = null;

			public void AggregateClauseReset()
			{
				_ACTINDX_W = null;
				_ACTNUMBR_1_W = null;
				_ACTNUMBR_2_W = null;
				_ACTNUMBR_3_W = null;
				_ACTNUMBR_4_W = null;
				_ACTNUMBR_5_W = null;
				_ACTNUMBR_6_W = null;
				_ACTNUMST_W = null;
				_DEX_ROW_ID_W = null;

				this._entity.Query.FlushAggregateParameters();

			}
	
			private BusinessEntity _entity;
			private TearOffAggregateParameter _tearOff;
			
		}
	
		public AggregateClause Aggregate
		{
			get
			{
				if(_aggregateClause == null)
				{
					_aggregateClause = new AggregateClause(this);
				}
		
				return _aggregateClause;
			}
		}
		
		private AggregateClause _aggregateClause = null;	
		#endregion
	
		protected override IDbCommand GetInsertCommand() 
		{
		
			SqlCommand cmd = new SqlCommand();
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.CommandText = "[" + this.SchemaStoredProcedure + "proc_GL00105Insert]";
	
			CreateParameters(cmd);
			
			SqlParameter p;
			p = cmd.Parameters[Parameters.DEX_ROW_ID.ParameterName];
			p.Direction = ParameterDirection.Output;
    
			return cmd;
		}
	
		protected override IDbCommand GetUpdateCommand()
		{
		
			SqlCommand cmd = new SqlCommand();
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.CommandText = "[" + this.SchemaStoredProcedure + "proc_GL00105Update]";
	
			CreateParameters(cmd);
			      
			return cmd;
		}
	
		protected override IDbCommand GetDeleteCommand()
		{
		
			SqlCommand cmd = new SqlCommand();
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.CommandText = "[" + this.SchemaStoredProcedure + "proc_GL00105Delete]";
	
			SqlParameter p;
			p = cmd.Parameters.Add(Parameters.ACTINDX);
			p.SourceColumn = ColumnNames.ACTINDX;
			p.SourceVersion = DataRowVersion.Current;

  
			return cmd;
		}
		
		private IDbCommand CreateParameters(SqlCommand cmd)
		{
			SqlParameter p;
		
			p = cmd.Parameters.Add(Parameters.ACTINDX);
			p.SourceColumn = ColumnNames.ACTINDX;
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.ACTNUMBR_1);
			p.SourceColumn = ColumnNames.ACTNUMBR_1;
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.ACTNUMBR_2);
			p.SourceColumn = ColumnNames.ACTNUMBR_2;
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.ACTNUMBR_3);
			p.SourceColumn = ColumnNames.ACTNUMBR_3;
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.ACTNUMBR_4);
			p.SourceColumn = ColumnNames.ACTNUMBR_4;
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.ACTNUMBR_5);
			p.SourceColumn = ColumnNames.ACTNUMBR_5;
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.ACTNUMBR_6);
			p.SourceColumn = ColumnNames.ACTNUMBR_6;
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.ACTNUMST);
			p.SourceColumn = ColumnNames.ACTNUMST;
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.DEX_ROW_ID);
			p.SourceColumn = ColumnNames.DEX_ROW_ID;
			p.SourceVersion = DataRowVersion.Current;


			return cmd;
		}
	}
}