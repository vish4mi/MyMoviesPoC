//
//  BaseDataTransaction+Querying.swift
//  CoreStore
//
//  Copyright © 2015 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import CoreData


// MARK: - DataTransaction

extension BaseDataTransaction: FetchableSource, QueryableSource {
    
    /**
     Deletes all `DynamicObject`s that satisfy the specified `DeleteClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter deleteClauses: a series of `DeleteClause` instances for the delete request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the number of `DynamicObject`s deleted
     */
    @discardableResult
    public func deleteAll<D>(_ from: From<D>, _ deleteClauses: DeleteClause...) -> Int? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to delete from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.deleteAll(from, deleteClauses)
    }
    
    /**
     Deletes all `DynamicObject`s that satisfy the specified `DeleteClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter deleteClauses: a series of `DeleteClause` instances for the delete request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the number of `DynamicObject`s deleted
     */
    @discardableResult
    public func deleteAll<D>(_ from: From<D>, _ deleteClauses: [DeleteClause]) -> Int? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to delete from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.deleteAll(from, deleteClauses)
    }
    
    /**
     Deletes all `DynamicObject`s that satisfy the specified conditions.
     ```
     transaction.deleteAll(From<Person>().where(\.age > 50))
     ```
     - parameter clauseChain: a `FetchChainableBuilderType` clause chain created from a `From` clause
     - returns: the number of `DynamicObject`s deleted
     */
    @discardableResult
    public func deleteAll<B: FetchChainableBuilderType>(_ clauseChain: B) -> Int? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to delete from a \(cs_typeName(self)) outside its designated queue."
        )
        
        return self.context.deleteAll(clauseChain.from, clauseChain.fetchClauses)
    }
    
    
    // MARK: FetchableSource
    
    /**
     Fetches the `DynamicObject` instance in the transaction's context from a reference created from a transaction or from a different managed object context.
     
     - parameter object: a reference to the object created/fetched outside the transaction
     - returns: the `DynamicObject` instance if the object exists in the transaction, or `nil` if not found.
     */
    public func fetchExisting<D: DynamicObject>(_ object: D) -> D? {
        
        return self.context.fetchExisting(object)
    }
    
    /**
     Fetches the `DynamicObject` instance in the transaction's context from an `NSManagedObjectID`.
     
     - parameter objectID: the `NSManagedObjectID` for the object
     - returns: the `DynamicObject` instance if the object exists in the transaction, or `nil` if not found.
     */
    public func fetchExisting<D: DynamicObject>(_ objectID: NSManagedObjectID) -> D? {
        
        return self.context.fetchExisting(objectID)
    }
    
    /**
     Fetches the `DynamicObject` instances in the transaction's context from references created from a transaction or from a different managed object context.
     
     - parameter objects: an array of `DynamicObject`s created/fetched outside the transaction
     - returns: the `DynamicObject` array for objects that exists in the transaction
     */
    public func fetchExisting<D: DynamicObject, S: Sequence>(_ objects: S) -> [D] where S.Iterator.Element == D {
        
        return self.context.fetchExisting(objects)
    }
    
    /**
     Fetches the `DynamicObject` instances in the transaction's context from a list of `NSManagedObjectID`.
     
     - parameter objectIDs: the `NSManagedObjectID` array for the objects
     - returns: the `DynamicObject` array for objects that exists in the transaction
     */
    public func fetchExisting<D: DynamicObject, S: Sequence>(_ objectIDs: S) -> [D] where S.Iterator.Element == NSManagedObjectID {
        
        return self.context.fetchExisting(objectIDs)
    }
    
    /**
     Fetches the first `DynamicObject` instance that satisfies the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the first `DynamicObject` instance that satisfies the specified `FetchClause`s
     */
    public func fetchOne<D>(_ from: From<D>, _ fetchClauses: FetchClause...) -> D? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchOne(from, fetchClauses)
    }
    
    /**
     Fetches the first `DynamicObject` instance that satisfies the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the first `DynamicObject` instance that satisfies the specified `FetchClause`s
     */
    public func fetchOne<D>(_ from: From<D>, _ fetchClauses: [FetchClause]) -> D? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchOne(from, fetchClauses)
    }
    
    /**
     Fetches the first `DynamicObject` instance that satisfies the specified `FetchChainableBuilderType` built from a chain of clauses.
     ```
     let youngestTeen = transaction.fetchOne(
         From<MyPersonEntity>()
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter clauseChain: a `FetchChainableBuilderType` built from a chain of clauses
     - returns: the first `DynamicObject` instance that satisfies the specified `FetchChainableBuilderType`
     */
    public func fetchOne<B: FetchChainableBuilderType>(_ clauseChain: B) -> B.ObjectType? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchOne(clauseChain)
    }
    
    /**
     Fetches all `DynamicObject` instances that satisfy the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: all `DynamicObject` instances that satisfy the specified `FetchClause`s
     */
    public func fetchAll<D>(_ from: From<D>, _ fetchClauses: FetchClause...) -> [D]? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchAll(from, fetchClauses)
    }
    
    /**
     Fetches all `DynamicObject` instances that satisfy the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: all `DynamicObject` instances that satisfy the specified `FetchClause`s
     */
    public func fetchAll<D>(_ from: From<D>, _ fetchClauses: [FetchClause]) -> [D]? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchAll(from, fetchClauses)
    }
    
    /**
     Fetches all `DynamicObject` instances that satisfy the specified `FetchChainableBuilderType` built from a chain of clauses.
     ```
     let people = transaction.fetchAll(
         From<MyPersonEntity>()
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter clauseChain: a `FetchChainableBuilderType` built from a chain of clauses
     - returns: all `DynamicObject` instances that satisfy the specified `FetchChainableBuilderType`
     */
    public func fetchAll<B: FetchChainableBuilderType>(_ clauseChain: B) -> [B.ObjectType]? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchAll(clauseChain)
    }
    
    /**
     Fetches the number of `DynamicObject`s that satisfy the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the number `DynamicObject`s that satisfy the specified `FetchClause`s
     */
    public func fetchCount<D>(_ from: From<D>, _ fetchClauses: FetchClause...) -> Int? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchCount(from, fetchClauses)
    }
    
    /**
     Fetches the number of `DynamicObject`s that satisfy the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the number `DynamicObject`s that satisfy the specified `FetchClause`s
     */
    public func fetchCount<D>(_ from: From<D>, _ fetchClauses: [FetchClause]) -> Int? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchCount(from, fetchClauses)
    }
    
    /**
     Fetches the number of `DynamicObject`s that satisfy the specified `FetchChainableBuilderType` built from a chain of clauses.
     ```
     let numberOfAdults = transaction.fetchCount(
         From<MyPersonEntity>()
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter clauseChain: a `FetchChainableBuilderType` built from a chain of clauses
     - returns: the number `DynamicObject`s that satisfy the specified `FetchChainableBuilderType`
     */
    public func fetchCount<B: FetchChainableBuilderType>(_ clauseChain: B) -> Int? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchCount(clauseChain)
    }
    
    /**
     Fetches the `NSManagedObjectID` for the first `DynamicObject` that satisfies the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the `NSManagedObjectID` for the first `DynamicObject` that satisfies the specified `FetchClause`s
     */
    public func fetchObjectID<D>(_ from: From<D>, _ fetchClauses: FetchClause...) -> NSManagedObjectID? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchObjectID(from, fetchClauses)
    }
    
    /**
     Fetches the `NSManagedObjectID` for the first `DynamicObject` that satisfies the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the `NSManagedObjectID` for the first `DynamicObject` that satisfies the specified `FetchClause`s
     */
    public func fetchObjectID<D>(_ from: From<D>, _ fetchClauses: [FetchClause]) -> NSManagedObjectID? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchObjectID(from, fetchClauses)
    }
    
    /**
     Fetches the `NSManagedObjectID` for the first `DynamicObject` that satisfies the specified `FetchChainableBuilderType` built from a chain of clauses.
     ```
     let youngestTeenID = transaction.fetchObjectID(
         From<MyPersonEntity>()
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter clauseChain: a `FetchChainableBuilderType` built from a chain of clauses
     - returns: the `NSManagedObjectID` for the first `DynamicObject` that satisfies the specified `FetchChainableBuilderType`
     */
    public func fetchObjectID<B: FetchChainableBuilderType>(_ clauseChain: B) -> NSManagedObjectID? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchObjectID(clauseChain)
    }
    
    /**
     Fetches the `NSManagedObjectID` for all `DynamicObject`s that satisfy the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the `NSManagedObjectID` for all `DynamicObject`s that satisfy the specified `FetchClause`s
     */
    public func fetchObjectIDs<D>(_ from: From<D>, _ fetchClauses: FetchClause...) -> [NSManagedObjectID]? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchObjectIDs(from, fetchClauses)
    }
    
    /**
     Fetches the `NSManagedObjectID` for all `DynamicObject`s that satisfy the specified `FetchClause`s. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter fetchClauses: a series of `FetchClause` instances for the fetch request. Accepts `Where`, `OrderBy`, and `Tweak` clauses.
     - returns: the `NSManagedObjectID` for all `DynamicObject`s that satisfy the specified `FetchClause`s
     */
    public func fetchObjectIDs<D>(_ from: From<D>, _ fetchClauses: [FetchClause]) -> [NSManagedObjectID]? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchObjectIDs(from, fetchClauses)
    }
    
    /**
     Fetches the `NSManagedObjectID` for all `DynamicObject`s that satisfy the specified `FetchChainableBuilderType` built from a chain of clauses.
     ```
     let idsOfAdults = transaction.fetchObjectIDs(
         From<MyPersonEntity>()
             .where(\.age > 18)
             .orderBy(.ascending(\.age))
     )
     ```
     - parameter clauseChain: a `FetchChainableBuilderType` built from a chain of clauses
     - returns: the `NSManagedObjectID` for all `DynamicObject`s that satisfy the specified `FetchChainableBuilderType`
     */
    public func fetchObjectIDs<B: FetchChainableBuilderType>(_ clauseChain: B) -> [NSManagedObjectID]? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to fetch from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.fetchObjectIDs(clauseChain)
    }
    
    
    // MARK: QueryableSource
    
    /**
     Queries aggregate values as specified by the `QueryClause`s. Requires at least a `Select` clause, and optional `Where`, `OrderBy`, `GroupBy`, and `Tweak` clauses.
     
     A "query" differs from a "fetch" in that it only retrieves values already stored in the persistent store. As such, values from unsaved transactions or contexts will not be incorporated in the query result.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter selectClause: a `Select<U>` clause indicating the properties to fetch, and with the generic type indicating the return type.
     - parameter queryClauses: a series of `QueryClause` instances for the query request. Accepts `Where`, `OrderBy`, `GroupBy`, and `Tweak` clauses.
     - returns: the result of the the query. The type of the return value is specified by the generic type of the `Select<U>` parameter.
     */
    public func queryValue<D, U: QueryableAttributeType>(_ from: From<D>, _ selectClause: Select<D, U>, _ queryClauses: QueryClause...) -> U? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to query from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.queryValue(from, selectClause, queryClauses)
    }
    
    /**
     Queries aggregate values or aggregates as specified by the `QueryClause`s. Requires at least a `Select` clause, and optional `Where`, `OrderBy`, `GroupBy`, and `Tweak` clauses.
     
     A "query" differs from a "fetch" in that it only retrieves values already stored in the persistent store. As such, values from unsaved transactions or contexts will not be incorporated in the query result.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter selectClause: a `Select<U>` clause indicating the properties to fetch, and with the generic type indicating the return type.
     - parameter queryClauses: a series of `QueryClause` instances for the query request. Accepts `Where`, `OrderBy`, `GroupBy`, and `Tweak` clauses.
     - returns: the result of the the query. The type of the return value is specified by the generic type of the `Select<U>` parameter.
     */
    public func queryValue<D, U: QueryableAttributeType>(_ from: From<D>, _ selectClause: Select<D, U>, _ queryClauses: [QueryClause]) -> U? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to query from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.queryValue(from, selectClause, queryClauses)
    }
    
    /**
     Queries a property value or aggregate as specified by the `QueryChainableBuilderType` built from a chain of clauses.
     
     A "query" differs from a "fetch" in that it only retrieves values already stored in the persistent store. As such, values from unsaved transactions or contexts will not be incorporated in the query result.
     ```
     let averageAdultAge = transaction.queryValue(
         From<MyPersonEntity>()
             .select(Int.self, .average(\.age))
             .where(\.age > 18)
     )
     ```
     - parameter clauseChain: a `QueryChainableBuilderType` indicating the property/aggregate to fetch and the series of queries for the request.
     - returns: the result of the the query as specified by the `QueryChainableBuilderType`
     */
    public func queryValue<B: QueryChainableBuilderType>(_ clauseChain: B) -> B.ResultType? where B.ResultType: QueryableAttributeType {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to query from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.queryValue(clauseChain.from, clauseChain.select, clauseChain.queryClauses)
    }
    
    /**
     Queries a dictionary of attribute values as specified by the `QueryClause`s. Requires at least a `Select` clause, and optional `Where`, `OrderBy`, `GroupBy`, and `Tweak` clauses.
     
     A "query" differs from a "fetch" in that it only retrieves values already stored in the persistent store. As such, values from unsaved transactions or contexts will not be incorporated in the query result.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter selectClause: a `Select<U>` clause indicating the properties to fetch, and with the generic type indicating the return type.
     - parameter queryClauses: a series of `QueryClause` instances for the query request. Accepts `Where`, `OrderBy`, `GroupBy`, and `Tweak` clauses.
     - returns: the result of the the query. The type of the return value is specified by the generic type of the `Select<U>` parameter.
     */
    public func queryAttributes<D>(_ from: From<D>, _ selectClause: Select<D, NSDictionary>, _ queryClauses: QueryClause...) -> [[String: Any]]? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to query from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.queryAttributes(from, selectClause, queryClauses)
    }
    
    /**
     Queries a dictionary of attribute values as specified by the `QueryClause`s. Requires at least a `Select` clause, and optional `Where`, `OrderBy`, `GroupBy`, and `Tweak` clauses.
     
     A "query" differs from a "fetch" in that it only retrieves values already stored in the persistent store. As such, values from unsaved transactions or contexts will not be incorporated in the query result.
     
     - parameter from: a `From` clause indicating the entity type
     - parameter selectClause: a `Select<U>` clause indicating the properties to fetch, and with the generic type indicating the return type.
     - parameter queryClauses: a series of `QueryClause` instances for the query request. Accepts `Where`, `OrderBy`, `GroupBy`, and `Tweak` clauses.
     - returns: the result of the the query. The type of the return value is specified by the generic type of the `Select<U>` parameter.
     */
    public func queryAttributes<D>(_ from: From<D>, _ selectClause: Select<D, NSDictionary>, _ queryClauses: [QueryClause]) -> [[String: Any]]? {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to query from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.queryAttributes(from, selectClause, queryClauses)
    }
    
    /**
     Queries a dictionary of attribute values or  as specified by the `QueryChainableBuilderType` built from a chain of clauses.
     
     A "query" differs from a "fetch" in that it only retrieves values already stored in the persistent store. As such, values from unsaved transactions or contexts will not be incorporated in the query result.
     ```
     let results = dataStack.queryAttributes(
         From<MyPersonEntity>()
             .select(
                 NSDictionary.self,
                 .attribute(\.age, as: "age"),
                 .count(\.age, as: "numberOfPeople")
              )
             .groupBy(\.age)
     )
     for dictionary in results! {
         let age = dictionary["age"] as! Int
         let count = dictionary["numberOfPeople"] as! Int
         print("There are \(count) people who are \(age) years old."
     }
     ```
     - parameter clauseChain: a `QueryChainableBuilderType` indicating the properties to fetch and the series of queries for the request.
     - returns: the result of the the query as specified by the `QueryChainableBuilderType`
     */
    public func queryAttributes<B: QueryChainableBuilderType>(_ clauseChain: B) -> [[String: Any]]? where B.ResultType == NSDictionary {
        
        CoreStore.assert(
            self.isRunningInAllowedQueue(),
            "Attempted to query from a \(cs_typeName(self)) outside its designated queue."
        )
        return self.context.queryAttributes(clauseChain.from, clauseChain.select, clauseChain.queryClauses)
    }
    
    
    // MARK: FetchableSource, QueryableSource
    
    /**
     The internal `NSManagedObjectContext` managed by this instance. Using this context directly should typically be avoided, and is provided by CoreStore only for extremely specialized cases.
     */
    public func unsafeContext() -> NSManagedObjectContext {
        
        return self.context
    }
    
    
    // MARK: Obsoleted
    
    @available(*, obsoleted: 3.1, renamed: "unsafeContext()")
    public func internalContext() -> NSManagedObjectContext {
        
        fatalError()
    }
}
